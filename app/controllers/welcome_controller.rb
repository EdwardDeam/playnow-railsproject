class WelcomeController < ApplicationController
  def index
    # A list of all active games.
    @list = GameList.new
    unless current_user.nil?
      user = User.find(current_user.id)
      @user_avatar = user.avatar
    end
  end
end
