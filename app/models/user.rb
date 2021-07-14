class User < ApplicationRecord
    has_many :user_preferences
    has_many :preferences, through: :user_preferences

    has_many :followers, foreign_key: :follower_id , class_name: "Friendship"
    has_many :followed, through: :followers
    has_many :followed, foreign_key: :followed_id, class_name: "Friendship"
    has_many :followers, through: :followed
    
end
