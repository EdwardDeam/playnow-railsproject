require_relative '../../../bin/debug.rb'
class DashboardController
  # Used for storing and sorting a list of user specific Game objects for display
  # on the dashboard page
  class GameList
    attr_accessor :all
    def initialize(current_user)
      @orders = current_user.orders.includes(:game, :publisher)
      @all = build_all
    end

    private

    def build_all
      games = []
      @orders.each do |o|
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
