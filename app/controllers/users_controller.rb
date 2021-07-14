class UsersController < ApplicationController
    def index
    end

    def new
        @user = User.new
        @preferences = Preference.all
    end

    def create

    end
end
