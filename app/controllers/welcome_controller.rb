class WelcomeController < ApplicationController
  def index
    # A list of all active games.
    @list = GameList.new
    user = User.find(current_user.id)
    @user_avatar = user.avatar
  end
end