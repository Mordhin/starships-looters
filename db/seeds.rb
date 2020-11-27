# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'date'
require 'open-uri'
# DELETING ALL DATA
Order.delete_all
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
ships_params = [{ name: "Pan Am Space Clipper", origin_universe: "2001: A Space Odyssey", img_url: 'https://i.pinimg.com/originals/fa/82/55/fa82551324064d40859f5e56ce029a56.jpg'},
  { name: "Discovery", origin_universe: "2001: A Space Odyssey", img_url: 'https://static.actu.fr/uploads/2020/08/25465-200817144359361-0-960x640.jpg'},
  { name: "USS Sulaco", origin_universe: "Alien", img_url: 'https://news.toyark.com/wp-content/uploads/sites/4/2020/04/HCG-Aliens-USS-Sulaco-001-928x483.jpg'},
  { name: "Millenium Falcon", origin_universe: "Star Wars", img_url: 'https://upload.wikimedia.org/wikipedia/en/8/8d/A_screenshot_from_Star_Wars_Episode_IV_A_New_Hope_depicting_the_Millennium_Falcon.jpg'},
  { name: "USCSS Nostromo", origin_universe: "Alien", img_url: 'https://images3.sw-cdn.net/product/picture/710x528_29342842_13439208_1603115454.jpg'},
  { name: "USS Reliant", origin_universe: "Star Trek", img_url: 'https://i.pinimg.com/originals/54/49/d9/5449d90f49aaa1640e360ced9ed683ed.jpg'},
  { name: "USS Enterprise", origin_universe: "Star Trek", img_url: 'https://hips.hearstapps.com/pop.h-cdn.co/assets/16/26/4000x2000/landscape-1467144815-starshipenterprise.jpg?resize=1200:*'},
  { name: "Motojet 74-Z", origin_universe: "Star Wars", img_url: 'https://static.wikia.nocookie.net/frstarwars/images/9/9b/Motojet_74-Z.png/revision/latest?cb=20171102082057'},
  { name: "Swordfish II", origin_universe: "Cowboy Bebop", img_url: 'https://i.redd.it/4d3thzud6y051.jpg'},
  { name: "FeeCo Train", origin_universe: "Oddworld", img_url: 'https://static.wikia.nocookie.net/oddworld/images/4/4a/Feeco_Depot_Train.jpg'},
  { name: "Pegasus", origin_universe: "Battlestar Galactica", img_url: 'https://rpggamer.org/uploaded_images/pegasus-04.jpg'},
  { name: "Thunderfighter", origin_universe: "Buck Rogers", img_url: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/ab940dbf-6b1c-43d5-9e49-aa8736340b2d/daqas05-136bdf1b-62dc-436b-95d2-1396e59847b5.jpg/v1/fill/w_1224,h_653,q_70,strp/buck_rogers___thunderfighter_remaster_by_adamkop_daqas05-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTM4NyIsInBhdGgiOiJcL2ZcL2FiOTQwZGJmLTZiMWMtNDNkNS05ZTQ5LWFhODczNjM0MGIyZFwvZGFxYXMwNS0xMzZiZGYxYi02MmRjLTQzNmItOTVkMi0xMzk2ZTU5ODQ3YjUuanBnIiwid2lkdGgiOiI8PTI2MDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.Dc2Z5Pnir9k4B5AsX9HgEAV0c9PmAeLu-bx9OFnH9YQ'},
  { name: "Death Star", origin_universe: "Star Wars", img_url: 'https://static.politico.com/7f/b0/a2005849462c82cd7c6ca47d5272/maga-pop-culture.jpg'},
  { name: "Arcadia", origin_universe: "Albator", img_url: 'http://i.imgur.com/VeMKKXu.png'},
  { name: "Bebop", origin_universe: "Cowboy Bebop", img_url: 'https://static.wikia.nocookie.net/cowboybebop/images/d/d1/Bebop_Exterior_Mars.png'},
  { name: "SSV Normandy", origin_universe: "Mass Effect", img_url: 'https://images6.fanpop.com/image/photos/37600000/SSV-NORMANDY-SR2-mass-effect-3-37648037-1191-670.jpg'}]
users = USERS_NAMES.reject { |x| x == 'admin'}
users.each do |user|
  4.times do
    break if ships_params.nil?

    ship = Ship.new(name: ships_params.last[:name], origin_universe: ships_params.last[:origin_universe])
    ship.photo.attach(io: open(ships_params.last[:img_url]), filename: "#{ships_params.last[:name]}-#{ships_params.last[:name]}")
    ships_params.pop
    puts ship.name
    ship.user_id = User.find_by_nickname(user).id
    ship.description = Faker::Movie.quote
    ship.location = Faker::Movies::StarWars.planet
    ship.price_per_day = Random.new.rand(10_000..999_999)
    ship.purpose = SHIPS_PURPOSES.sample
    ship.size = SHIPS_SIZES.sample
    ship.crew_capacity = Random.new.rand(1..12_000)
    ship.available = true
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
    total_amount = Random.new.rand(10_000..999_999)
    Booking.create!(
      user_id: user.id,
      ship_id: ship.id,
      date_start: random_date,
      date_end: random_date + Random.new.rand(1..30),
      crew_size: (1..ship.crew_capacity).to_a.sample,
      status: BOOKINGS_STATUSES_WITHOUT_CLOSED.sample,
      total_amount: total_amount,
      price_cents: total_amount*100
    )
  end
end
