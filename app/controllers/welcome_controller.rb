class WelcomeController < ApplicationController
  def index
    # A list of all active games.
    @list = GameList.new
  end
end