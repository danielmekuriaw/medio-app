class UsersController < ApplicationController

  
    def index
    end

    def new
        @user = User.new
        @preferences = Preference.all
    end

    def create
        byebug
        @user = User.create(user_params)

        if @user.valid?
          @user.save
          redirect_to user_path(@user)
        else
          render :new
        end
    end


    private

    def user_params
        #params.require(:user).permit(:)
    end
end
