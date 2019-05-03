require_relative '../../../bin/debug.rb'
class DashboardController
  # Used for storing and sorting a list of user specific Game objects for display
  # on the dashboard page
  class GameList
    attr_accessor :user
    def initialize(current_user)
      Debug.console('GameList Current User', current_user.username)
      @user = current_user
    end
  end
end
