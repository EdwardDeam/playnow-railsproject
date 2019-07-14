#  Collection of fake data
require 'faker'

puts "Start of Seeding"
puts
puts 'Creating regular users...'
regular1 = User.create({ :email => 'user1@test.com', username: Faker::TvShows::RickAndMorty.character, :first_name => 'Harry', :last_name => 'Smith', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => false})
regular2 = User.create({ :email => 'user2@test.com', username: Faker::TvShows::RickAndMorty.character, :first_name => 'Anna', :last_name => 'Jones', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => false})
regular3 = User.create({ :email => 'user3@test.com', username: Faker::TvShows::RickAndMorty.character, :first_name => 'John', :last_name => 'Doe', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => false})
puts "User #{regular1.username}\t with email #{regular1.email} created!"
puts "User #{regular2.username}\t with email #{regular2.email} created!"
puts
puts 'Creating publisher users...'
pub1 = User.create({ :email => 'pub1@test.com', username: Faker::TvShows::RickAndMorty.character, :first_name => 'William', :last_name => 'Fence', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => true})
pub2 = User.create({ :email => 'pub2@test.com', username: Faker::TvShows::RickAndMorty.character, :first_name => 'William', :last_name => 'Chris', :password => 'qwert123', :password_confirmation => 'qwert123', :seller => true})
puts "Publisher #{pub1.username}\t with email #{pub1.email} created!"
puts "Publisher #{pub2.username}\t with email #{pub2.email} created!"
# Create the Publisher Objects for publisher users
pub1_obj = Publisher.new({ description: Faker::TvShows::RickAndMorty.quote  })
pub2_obj = Publisher.new({ description: Faker::TvShows::RickAndMorty.quote  })
# Attach a user to the publisher
pub1_obj.user_id = pub1.id
pub2_obj.user_id = pub2.id
# Save the publisher so we can add games
pub1_obj.save
pub2_obj.save
puts
puts 'Generating Games...'

10.times do 
  pub1_obj.games.create({
    active: true,
    title: Faker::Marketing.buzzwords.capitalize,
    genre: Faker::Game.genre,
    price: rand(999..9999),
    description: Faker::Lorem.paragraph_by_chars(400)
  })
  pub2_obj.games.create({
    active: true,
    title: Faker::Marketing.buzzwords.capitalize,
    genre: Faker::Game.genre,
    price: rand(999..9999),
    description: Faker::Lorem.paragraph_by_chars(400)
  })
end


games = Game.all
games.each do |g|
  4.times do
    img_num = rand(1...10)
    g.images.attach(io: File.open("app/assets/images/#{img_num}.jpg"), filename: "#{img_num}.jpg", content_type: 'image/jpg')
  end
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