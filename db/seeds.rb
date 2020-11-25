# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'date'
# DELETING ALL DATA
Booking.delete_all
Ship.delete_all
User.delete_all

# USERS SEEDING : ONE FOR EACH + ONE ADMIN
USERS_NAMES = ['julien', 'adrien', 'jp', 'stephane', 'admin']
USERS_NAMES.each do |username|
  User.create!(
    email: "#{username}@email.com",
    nickname: username,
    password: '123456',
    password_confirmation: '123456',
    admin: username == 'admin'
  )
end

# SHIPS SEEDING
SHIPS_SIZES = ['micro', 'small', 'big', 'planetwide']
SHIPS_PURPOSES = ['war', 'holiday', 'race', 'planet eradication', 'galactical space party']
ships_params = [{ name: "Pan Am Space Clipper", origin_universe: "2001: A Space Odyssey"},
  { name: "Discovery", origin_universe: "2001: A Space Odyssey"},
  { name: "USS Sulaco", origin_universe: "Alien"},
  { name: "Millenium Falcon", origin_universe: "Star Wars"},
  { name: "USCSS Nostromo", origin_universe: "Alien"},
  { name: "USS Reliant", origin_universe: "Star Trek"},
  { name: "USS Enterprise", origin_universe: "Star Trek"},
  { name: "Motojet 74-Z", origin_universe: "Star Wars"},
  { name: "Swordfish II", origin_universe: "Cowboy Bebop"},
  { name: "FeeCo Train", origin_universe: "Oddworld"},
  { name: "Colonial Shuttle", origin_universe: "Battlestar Galactica"},
  { name: "Thunderfighter", origin_universe: "Buck Rogers"},
  { name: "Death Star", origin_universe: "Star Wars"},
  { name: "Arcadia", origin_universe: "Albator"},
  { name: "Bebop", origin_universe: "Cowboy Bebop"},
  { name: "SSV Normandy", origin_universe: "Mass Effect"}]
users = USERS_NAMES.reject { |x| x == 'admin'}
users.each do |user|
  4.times do
    break if ships_params.nil?

    ship = Ship.new(ships_params.last)
    ships_params.pop
    ship.user_id = User.find_by_nickname(user).id
    ship.description = Faker::Movie.quote
    ship.location = Faker::Movies::StarWars.planet
    ship.price_per_day = Random.new.rand(10_000..999_999_999)
    ship.purpose = SHIPS_PURPOSES.sample
    ship.size = SHIPS_SIZES.sample
    ship.crew_capacity = Random.new.rand(1..12_000)
    ship.save
  end
end

# BOOKINGS SEEDING
BOOKINGS_STATUSES = ['pending', 'validated', 'cancelled', 'paid', 'closed']
BOOKINGS_STATUSES_WITHOUT_CLOSED = ['pending', 'validated', 'cancelled', 'paid']
User.all.each do |user|
  other_ships = Ship.where('user_id != ?', user.id)
  3.times do
    year = [2021, 2022, 2023].sample
    month = (1..12).to_a.sample
    day = (1..28).to_a.sample
    ship = other_ships.sample
    random_date = Date.new(year, month, day)
    Booking.create!(
      user_id: user.id,
      ship_id: ship.id,
      date_start: random_date,
      date_end: random_date + Random.new.rand(1..30),
      crew_size: (1..ship.crew_capacity).to_a.sample,
      status: BOOKINGS_STATUSES_WITHOUT_CLOSED.sample
    )
  end
end
