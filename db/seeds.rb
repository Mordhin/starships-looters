# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# USERS SEEDING : ONE FOR EACH + ONE ADMIN
Booking.delete_all
Ship.delete_all
User.delete_all

USERS_NAMES = ['adrien', 'julien', 'jp', 'stephane', 'admin']
USERS_NAMES.each do |username|
  User.create!(
    email: "#{username}@email.com",
    nickname: username,
    password: '123456',
    password_confirmation: '123456',
    admin: username == 'admin'
  )
end
