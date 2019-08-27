class WelcomeController < ApplicationController
  class GameList
    attr_reader :list
    def initialize(search_params = 'all')
      if search_params == 'all'
        @list = load_all
      end
    end

    def length
      @list.length
    end

    def game_title(index)
      @list[index][:title]
    end

    def game_publisher(index)
      @list[index][:publisher]
    end

    def game_price(index)
      @list[index][:price]
    end

    def game_image(index)
      @list[index][:image]
    end

    def game_genre(index)
      @list[index][:genre]
    end

    def game_id(index)
      @list[index][:id]
    end
    
    private

    def load_all
      # Load every game and its publishers username
      # only load active games
      games = []
      list = Game.with_attached_images.includes(publisher: [:user]).select { |game| game.active == true }
      list.each do |game|
        games << {
          title: game.title,
          publisher: game.publisher.user.username,
          price: game.price_to_string,
          image: game.images[0],
          genre: game.genre,
          id: game.id
        }
      end
      return games.reverse!
    end

  end
end
