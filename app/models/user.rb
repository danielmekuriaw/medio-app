class User < ApplicationRecord
    has_many :user_preferences
    has_many :preferences, through: :user_preferences

    has_many :followers, foreign_key: :follower_id , class_name: "Friendship"
    has_many :followed, through: :followers
    has_many :followed, foreign_key: :followed_id, class_name: "Friendship"
    has_many :followers, through: :followed

    has_many :locations
    has_many :journeys

    #Validations

    #validates :username, presence: true, uniqueness: true
    #validates :bio, presence: true, length: { minimum: 100 }
    #validates :age, numericality: {greater_than: 0, less_than: 120, only_integer: true}
    
    #validates_date :birth_date, on_or_before: lambda { Date.current }

    #validates :email, presence: true, uniqueness: true

    def following
        User.all.select{ |user|
            user.followers.include? self
        }
    end

    def name
        self.first_name + " " + self.last_name
    end

end
