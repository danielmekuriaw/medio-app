class User < ApplicationRecord
    has_many :user_preferences
    has_many :preferences, through: :user_preferences
    
end
