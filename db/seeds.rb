# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_1 = User.create!(name:  "Mikhail",
             email: "mikhail771@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

user_2 = User.create!(name:  "Александр",
             email: "sasha@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
35.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(body: content, wall_id: users.sample.wall.id) }
end
