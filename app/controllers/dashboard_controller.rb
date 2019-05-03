class DashboardController < ApplicationController
  def index
    @games = GameList.new(current_user)
  end
end
