# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

#Create a wall (App CANNOT run without a wall model instance)
Wall.create()

#Generate random users and profile bios.
10.times do
    new_user = User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456",
        gender: 0,
        birth_date: Faker::Date.birthday(min_age: 18, max_age: 65)
    )
    new_user.profile.update!(
        bio: Faker::Quote.famous_last_words
    )
end