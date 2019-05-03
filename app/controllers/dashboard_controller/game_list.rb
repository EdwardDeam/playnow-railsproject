
class DashboardController
  # Used for storing and sorting a list of user specific Game objects for display
  # on the dashboard page
  class GameList
    attr_accessor :all, :length
    def initialize(current_user)
      @all = build_all(current_user)
      @length = @all.length
    end

    def game_title(index)
      @all[index][:title]
    end

    def game_publisher(index)
      @all[index][:publisher]
    end

    def game_key(index)
      @all[index][:key]
    end

    private

    def build_all(user)
      games = []
      user.orders.includes(:game, publisher: [:user]).each do |o|
        games << {
          title: o.game.title,
          publisher: o.publisher.user.username,
          key: o.game_key
        }
      end
      return games
    end

  end
end
