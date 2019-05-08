class DashboardController < ApplicationController
  def index
    @games = OrderList.new(current_user)

    # Only load the editable games if the user is a publisher.
    unless current_user.publisher.nil?
      @published = Game.where(publisher_id: current_user.publisher.id, active: true)
    end
  end
end
