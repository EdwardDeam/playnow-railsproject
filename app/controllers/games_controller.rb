class GamesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]
  def show
    @game = Game.find(params[:id])
  end
end
