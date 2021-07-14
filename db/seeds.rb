# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Preference.destroy_all

10.times do
    user= User.create!(first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name, username: Faker::FunnyName.name, bio: Faker::Company.bs, age: rand(10..50), birth_date: Faker::Date.in_date_period.to_datetime )
    user.followers << User.create(first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name, username: Faker::FunnyName.name, bio: Faker::Company.bs, age: rand(10..50), birth_date: Faker::Date.in_date_period.to_datetime )
end
#puts User.all.count
User.all.each do |user|
    #puts user
    user.followers.each do |follower|
        puts follower
    end
end

preferences = [:airport, :aquarium, :art_gallery, 
    :bakery, :bank, :bar, :beauty_salon, :book_store, 
    :bowling_alley, :bus_station, :cafe, :casino, 
    :cemetery, :church, :city_hall, :department_store, 
    :electronics_store, :furniture_store, :gas_station, :gym, :hair_care, :hindu_temple, 
    :hospital, :jewelry_store, :laundry, :library, :liquor_store, :mosque, :movie_theater, 
    :museum, :night_club, :park, :pet_store, :pharmacy, :restaurant, :shopping_mall, 
    :spa, :stadium, :subway_station, :supermarket, :synagogue, :taxi_stand, :tourist_attraction, 
    :train_station, :transit_station, :university, :zoo]

preferences.each{ |preference|
    Preference.create(preference_type: preference.to_s)
    #puts preference.to_s
}

puts "Finished creating preferences!"
