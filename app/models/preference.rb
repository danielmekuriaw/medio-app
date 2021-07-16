class Preference < ApplicationRecord
    has_many :user_preferences
    has_many :users, through: :user_preferences

    def proper_name
        self.preference_type.split('_').map(&:capitalize).join(' ')
    end
    
end
