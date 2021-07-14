# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

10.times do
    user= User.create(first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name, age: rand(10..50), birth_date: Faker::Date.in_date_period.to_datetime )
    user.followers << User.create(first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name, age: rand(10..50), birth_date: Faker::Date.in_date_period.to_datetime )
end

User.all.each{ |user|
    user.followers.each{ |follower|
        puts follower.first_name
    }
}
