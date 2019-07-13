# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Start of Seeding"
puts
puts 'Creating regular users...'
regular1 = User.create({ :email => 'user1@test.com', :username => 'Ignignokt', :first_name => 'Harry', :last_name => 'Smith', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => false})
regular2 = User.create({ :email => 'user2@test.com', :username => 'Handbanana', :first_name => 'Anna', :last_name => 'Jones', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => false})
regular3 = User.create({ :email => 'user3@test.com', :username => 'MasterShake', :first_name => 'John', :last_name => 'Doe', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => false})
puts "User #{regular1.username}\t with email #{regular1.email} created!"
puts "User #{regular2.username}\t with email #{regular2.email} created!"
puts
puts 'Creating publisher users...'
pub1 = User.create({ :email => 'pub1@test.com', :username => 'Mitrosoft', :first_name => 'William', :last_name => 'Fence', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => true})
pub2 = User.create({ :email => 'pub2@test.com', :username => 'SpaceResident', :first_name => 'Robert', :last_name => 'Chris', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => true})
puts "Publisher #{pub1.username}\t with email #{pub1.email} created!"
puts "Publisher #{pub2.username}\t with email #{pub2.email} created!"
# Create the Publisher Objects for publisher users
pub1_obj = Publisher.new({ description: 'What would you like to do today?' })
pub2_obj = Publisher.new({ description: 'Comming soon...' })
# Attach a user to the publisher
pub1_obj.user_id = pub1.id
pub2_obj.user_id = pub2.id
# Save the publisher so we can add games
pub1_obj.save
pub2_obj.save
puts
puts 'Generating Games...'
pub1_obj.games.create({active: true, title: 'MitroSoft Game One', genre: 'RPG', price: 1999, description: 'Description of game one'})
pub1_obj.games.create({active: true, title: 'MitroSoft Game Two', genre: 'Strategy', price: 1399, description: 'Description of game two'})
pub1_obj.games.create({active: true, title: 'MitroSoft Game Three', genre: 'FPS', price: 1999, description: 'Description of game three'})
pub1_obj.games.create({active: true, title: 'MitroSoft Game Four', genre: 'RPG', price: 1599, description: 'Description of game four'})
pub2_obj.games.create({active: true, title: 'Space Game One', genre: 'Strategy', price: 2999, description: 'Description of game two'})
pub2_obj.games.create({active: true, title: 'Space Game Two', genre: 'Undefinable', price: 2999, description: 'The greatest game known to man'})

games = Game.all
games.each do |g|
  g.images.attach(io: File.open('app/assets/images/1.jpg'), filename: '1.jpg', content_type: 'image/jpg')
  puts "Game #{g.title} created."
end
puts
puts 'Generating orders...'
orders = [
  Order.create({user: regular1, publisher: pub1_obj, game: pub1_obj.games.first }),
  Order.create({user: regular2, publisher: pub1_obj, game: pub1_obj.games.last }),
  Order.create({user: regular3, publisher: pub1_obj, game: pub2_obj.games.first}),
  Order.create({user: regular1, publisher: pub2_obj, game: pub1_obj.games.first}),
  Order.create({user: regular2, publisher: pub2_obj, game: pub2_obj.games.last }),
  Order.create({user: regular3, publisher: pub1_obj, game: pub2_obj.games.last }),
  Order.create({user: regular3, publisher: pub2_obj, game: pub2_obj.games.last }),
  Order.create({user: regular2, publisher: pub2_obj, game: pub1_obj.games.first }),
  Order.create({user: regular1, publisher: pub1_obj, game: pub2_obj.games.last }),
  Order.create({user: pub1, publisher: pub2_obj, game: pub1_obj.games.first }),
  Order.create({user: pub1, publisher: pub2_obj, game: pub1_obj.games.last })
]

orders.each do |o|
  puts "User #{o.user.username}  \tKey #{o.game_key}"
end
puts
puts "Seeding Over"