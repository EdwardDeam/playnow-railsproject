class DashboardController < ApplicationController
  def index
    @games = OrderList.new(current_user)
    @user_avatar = current_user.avatar
    # Only load the editable games if the user is a publisher.
    unless current_user.publisher.nil?
      @published = Game.where(publisher_id: current_user.publisher.id, active: true)
    end
  end
end
