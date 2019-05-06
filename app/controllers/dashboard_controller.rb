class DashboardController < ApplicationController
  def index
    @games = GameList.new(current_user)

    unless current_user.publisher.nil?
      @published = Game.where(publisher_id: current_user.publisher.id, active: true)
    end
  end
end
