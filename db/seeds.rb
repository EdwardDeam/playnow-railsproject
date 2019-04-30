# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating a regular user'
regular = User.create({ :email => 'user@user.com.au', :username => 'user', :first_name => 'user', :last_name => 'user', :password => 'password123', :password_confirmation => 'password123'})
puts regular.email
puts 'Creating a publisher user'
store = User.create({ :email => 'publisher@publisher.com.au', :username => 'user', :first_name => 'publisher', :last_name => 'publisher', :password => 'password123', :password_confirmation => 'password123'})
puts store.email

# Attach a publisher to the user
publisher_obj = Publisher.new({ description: 'test description' })
publisher_obj.user_id = store.id
publisher_obj.save!

puts 'Generating Games...'
publisher_obj.games.create({title: 'Game One', genre: 'RPG', price: 1000, description: 'Description of game one'})
publisher_obj.games.create({title: 'Game Two', genre: 'Strategy', price: 1560, description: 'Description of game two'})
publisher_obj.games.create({title: 'Game Three', genre: 'FPS', price: 3450, description: 'Description of game three'})

puts 'Generating orders...'
order1 = Order.create({user: regular, publisher: publisher_obj, game: publisher_obj.games.first, game_key: 'XXXXXXXXX'})
puts order1.game_key
order1.save!
puts "Seeding Over"

