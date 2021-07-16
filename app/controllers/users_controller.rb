class UsersController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:show, :edit, :update, :delete, :followers, :following, :follow, :meet_view]
    
    def aboutus
    end

    def new
        @user = User.new
        @preferences = Preference.all
    end

    def create
        user_params_temp = user_params
        user_params_temp.delete(:preferences)
        user_params_temp.delete(:location)
        @user = User.new(user_params_temp)
        
        selected_preferences.each{ |preference|
            @user.preferences << Preference.find_by(preference_type: preference)
        }
        
        if @user.save
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        session[:journey_started] = false
    end

    def edit
        @user = User.find_by(id: params[:id])
        @user.preferences = Array.new
        @preferences = Preference.all
    end

    def update
        @user = User.find_by(id: params[:id])
        user_params_temp = user_params
        user_params_temp.delete(:preferences)
        @user.update(user_params_temp)

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
        @follow_each_other = @user.follow_each_other
        @user_not_following_back = @user.user_not_following_back
        @no_friendship = @user.no_friendship
    end

    def following
        @user = User.find_by(id: params[:id])
        @following = @user.following
        @not_following = @user.not_following
    end

    def follow
        @user = User.find_by(id: params[:id])
        @followed = User.find_by(id: params[:to_be_followed_id])
        @followed.followers << @user
        @followed.save

        redirect_back fallback_location: @user
    end

    def remove
        @user = User.find_by(id: params[:id])
        @followed = User.find_by(id: params[:to_be_followed_id])
        @user.followers.delete(@followed)
        @followed.save

        redirect_back fallback_location: @user
    end

    def unfollow
        @user = User.find_by(id: params[:id])
        @followed = User.find_by(id: params[:to_be_followed_id])
        @followed.followers.delete(@user)
        @followed.save

        redirect_back fallback_location: @user
    end

    def meet_view
        @user = User.find_by(id: params[:id])
        @journey = Journey.new
        @preferences = @user.preferences.map{
            |preference| preference.proper_name
        }
        @user_following = @user.following
    end

    def meet_request
        @journey = Journey.create(journey_params)
        #byebug
        #@journey.user = current_user
        
        redirect_to "/journeys/#{@journey.id}/meet_view"
    end    


    #------------------------------------------------------------------ Private Methods

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
        params.require(:user).permit(:first_name, :last_name, :username, :age, :birth_date, :bio, :location, :password, preferences: preferences)
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

    def journey_params
        #byebug
        params.require(:journey).permit(:point1, :point2, :radius, :mode, :preference)
    end

end
