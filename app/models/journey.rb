class Journey < ApplicationRecord
    #belongs_to :user

    def suggestions
        point1 = self.point1
        point2 = self.point2

        firstOriginAddress = formatted_Address(point1)
        secondOriginAddress = formatted_Address(point2)
        mode = self.mode
        keyword = self.preference
        radius = self.radius

        address = formatted_Address(firstOriginAddress)
        lat, lng = get_lat_lng(address)
        latitude1 = lat
        longitude1 = lng

        address = formatted_Address(secondOriginAddress)
        lat, lng = get_lat_lng(address)
        latitude2 = lat
        longitude2 = lng

        geo = geodesic_inverse(latitude1, longitude1, latitude2, longitude2)
        midpoint = geodesic_direct(latitude1, longitude1, geo)

        midlatx = midpoint[:lat2]
        midlongx = midpoint[:lon2]

        url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{midlatx},#{midlongx}&radius=#{radius}&keyword=#{keyword}&key=#{self.api_key}"

        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
        places = JSON.parse(response)

        results = places["results"]

        names = Array.new
        locations = Array.new
        ids = Array.new

        for result in results
            names << result["name"]
            locations << result["geometry"]["location"]
            ids << result["place_id"]
        end

        #Find optimal destination
        optimal = optimization(firstOriginAddress, secondOriginAddress, locations, names)
        final_results = Array.new

        optimal.each{ |optimal|
            temp_hash = Hash.new
            temp_hash[:location_info] = locator(optimal[:place]["lat"], optimal[:place]["lng"], optimal[:name])
            temp_hash[:time1] = optimal[:time1]
            temp_hash[:time2] = optimal[:time2]
            temp_hash[:distance1]= optimal[:distance1]
            temp_hash[:distance2]= optimal[:distance2]
            final_results << temp_hash
        }        
        
        #byebug
        return final_results

    end

    def api_key
        return 'AIzaSyAmCf0SWHM3vMqJi6oCkLkPaRq3GJ57tis'
    end

    def gmaps
        gmaps = GoogleMapsService::Client.new(key: self.api_key)
        return gmaps
    end

    def geodesic_inverse(latitude1, longitude1, latitude2, longitude2)
        geo = GeographicLib::Geodesic::WGS84.inverse(latitude1, longitude1, latitude2, longitude2)
        return geo
    end

    def geodesic_direct(latitude1, longitude1, geo)
        midpoint = GeographicLib::Geodesic::WGS84.direct(latitude1, longitude1, geo[:azi1], false, geo[:s12]/2)
        return midpoint
    end

    

    def formatted_Address(keyword)
        gmaps = self.gmaps       
        url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{keyword}&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=#{api_key}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)["candidates"].first["formatted_address"]
    end

    def get_lat_lng(address)
        gmaps = self.gmaps
    
        result = gmaps.geocode(address: address)
        lat = result[0][:geometry][:location][:lat]
        lng = result[0][:geometry][:location][:lng]
        
        coordinate = Array.new
        coordinate << lat
        coordinate << lng
        return coordinate
    end

    def distanceCalc(point1, point2)
        gmaps = self.gmaps
        result = gmaps.distance_matrix(point1, point2)
        distance_taken = result[:rows].first[:elements].first
        puredistance = distance_taken[:distance][:value]
        return (puredistance / 2).to_i
    end 
    
    def routeFinder(point1, point2, destination, mode)
        gmaps = self.gmaps
     
        directions = gmaps.directions(point1, destination, mode: mode)
        #puts directions
        #puts 
        steps = directions.first[:legs].first[:steps]
        
        steps_for_1 = Array.new

        for step in steps
            text = step[:html_instructions]
            text = text.gsub("<div.*?>", ". ")
            text = text.gsub("<.*?>", "")
            steps_for_1 << step[:distance][:text] + " / " + step[:duration][:text] + " - " + text + "."
        end

        steps_for_2 = Array.new
     
        directions = gmaps.directions(point2, destination, mode: mode)
    
        steps = directions.first[:legs].first[:steps]
     
        for step in steps
            text = step[:html_instructions]
            text = text.gsub("<div.*?>", ". ")
            text = text.gsub("<.*?>", "")
            steps_for_2 << step[:distance][:text] + " / " + step[:duration][:text] + " - " + text + "."
        end

        final_directions = Hash.new
        final_directions[:steps_for_1] = steps_for_1
        final_directions[:steps_for_2] = steps_for_2

        return final_directions
    end
    
    def optimization(location1, location2, destinations, names)
        gmaps = self.gmaps
    
        origin1 = location1
        origin2 = location2
        destination_data = Array.new
    
        index = 0
    
        for place in destinations
            destination_hash = Hash.new
    
            distances_taken1 = gmaps.distance_matrix(origin1, place)[:rows].first[:elements].first
            distances_taken2 = gmaps.distance_matrix(origin2, place)[:rows].first[:elements].first
    
            destination_hash[:place] = place
            destination_hash[:name] = names[index]
    
            d = (distances_taken1[:distance][:value])# in meters
            destination_hash[:distance1] = d
    
            d2 = (distances_taken2[:distance][:value])# in meters
            destination_hash[:distance2] = d2
    
            t = (distances_taken1[:duration][:value] / 60) #in minutes
            destination_hash[:time1] = t

            t2 = (distances_taken2[:duration][:value] / 60) #in minutes
            destination_hash[:time2] = t2
    
            totalt = (t + t2)
            timedif = (t - t2).abs()
    
            cost = totalt * timedif
            destination_hash[:cost] = cost
            destination_data << destination_hash
    
            index = index + 1
        end

        sorted_destination_data =destination_data.sort_by{ |hash|
            hash[:cost]
        }
    
        return sorted_destination_data
    end 


    def locator(lat, long, name)
        gmaps = self.gmaps
            
        url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&name=#{name}&radius=100&key=#{api_key}"
        
        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
        places = JSON.parse(response)

    end

    def extract_name(data)
        if data[:location_info]
            if data[:location_info]["results"]
                if data[:location_info]["results"].first["name"]
                    return data[:location_info]["results"].first["name"]
                else
                    return nil
                end
            else
                return nil
            end
        else
            return nil
        end
    end

    def status_now(data)
        if data[:location_info]["results"].first["opening_hours"]
            if data[:location_info]["results"].first["opening_hours"]["open_now"]
                return "Open"
            else
                return "Closed"
            end
        else
            return nil
        end
    end

    def tags(data)
        data[:location_info]["results"].first["types"]
    end

    def vicinity(data)
        data[:location_info]["results"].first["vicinity"]
    end

    def rating(data)
        if data[:location_info]["results"].first["rating"] != 0
            data[:location_info]["results"].first["rating"]
        else
            return nil
        end
    end

    def point1_distance(data)
        data[:distance1]
    end

    def point2_distance(data)
        data[:distance2]
    end

    def point1_time(data)
        data[:time1]
    end

    def point2_time(data)
        data[:time2]
    end

    def proper_name(name)
        name.split('_').map(&:capitalize).join(' ')
    end  
    


end
