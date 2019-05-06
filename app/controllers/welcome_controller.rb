class WelcomeController < ApplicationController
  def index
    @list = GameList.new
  end
end