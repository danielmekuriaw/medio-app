class UsersController < ApplicationController
    def index
    end

    def new
        @user = User.new
        @preferences = Preference.all
    end

    def create
        user_params_temp = user_params
        user_params_temp.delete(:preferences)
        @user = User.new(user_params_temp)
        
        selected_preferences.each{ |preference|
            @user.preferences << Preference.find_by(preference_type: preference)
        }
        
        if @user.valid?
          @user.save
          redirect_to user_path(@user)
        else
          render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def edit
        @user = User.find_by(id: params[:id])
        @preferences = Preference.all
    end

    def update
        @user = User.find_by(id: params[:id])
        user_params_temp = user_params
        user_params_temp.delete(:preferences)
        @user = User.new(user_params_temp)

        selected_preferences.each{ |preference|
            @user.preferences << Preference.find_by(preference_type: preference)
        }

        if @user.valid?
            @user.save
            redirect_to user_path(@user)
        else
            render :edit
        end

    end

    def delete
        @user = User.find_by(id: params[:id])
        @user.destroy
        redirect_to new_user_path
    end

    #--------------------------------------------------------------------- Non-CRUD methods

    def followers
        @user = User.find_by(id: params[:id])
        
        @following = User.all.select{|user| user.followers.include? @user}
        @not_following = User.all.select{|user| !user.followers.include? @user}
    end

    def following
        @user = User.find_by(id: params[:id])
        @following = User.all.select{|user| user.followers.include? @user}
        @not_following = User.all.select{|user| !user.followers.include? @user}
    end

    def follow
        @user = User.find_by(id: params[:id])
        @followed = User.find_by(id: params[:to_be_followed_id])
        @followed.followers << @user

        redirect_to user_path(@followed)
    end

    


    private

    def user_params
        preferences = [:airport, :aquarium, :art_gallery, 
            :bakery, :bank, :bar, :beauty_salon, :book_store, 
            :bowling_alley, :bus_station, :cafe, :casino, 
            :cemetery, :church, :city_hall, :department_store, 
            :electronics_store, :furniture_store, :gas_station, :gym, :hair_care, :hindu_temple, 
            :hospital, :jewelry_store, :laundry, :library, :liquor_store, :mosque, :movie_theater, 
            :museum, :night_club, :park, :pet_store, :pharmacy, :restaurant, :shopping_mall, 
            :spa, :stadium, :subway_station, :supermarket, :synagogue, :taxi_stand, :tourist_attraction, 
            :train_station, :transit_station, :university, :zoo]
        params.require(:user).permit(:first_name, :last_name, :username, :age, :birth_date, :bio, preferences: preferences)
    end

    def selected_preferences
        temp_array = []
        user_params[:preferences].select{ |key, value|
            value == "1"
        }.each{ |key, value|
            temp_array << key
        }
        temp_array
    end

end
