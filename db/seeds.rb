# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating an admin user'
User.new({ :email => 'user@user.com.au', :username => 'user', :first_name => 'user', :last_name => 'user', :password => 'password123', :password_confirmation => 'password123'}).save

User.new({ :email => 'publisher@publisher.com.au', :username => 'user', :first_name => 'publisher', :last_name => 'publisher', :password => 'password123', :password_confirmation => 'password123'}).save
puts "Seeding Over"