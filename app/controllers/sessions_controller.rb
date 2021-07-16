class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by_username(params[:user][:username])

        if @user && @user.authenticate(params[:user][:password])
            flash[:message] = "Successfully logged in!"
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:message] = "Login failed!"
            render :new
        end

    end

    def destroy
        session.clear
        redirect_to login_path
    end

end
