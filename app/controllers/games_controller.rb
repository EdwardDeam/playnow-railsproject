class GamesController < ApplicationController
  load_and_authorize_resource
  # skip_authorize_resource :only => [:new, :create]
  def show
    @game = Game.find(params[:id])
  end

  def new
    # Check that the registered user is a publisher
    unless current_user.publisher.nil?
      # TODO: Throw error Letting user know that they need the be a publisher to publish a a game
      #       May be able to avoid this with blocking the page to users who arent publishers
      @game = Game.new
    end
  end

  def create
    unless current_user.publisher.nil?
      puts "*"*20
      puts "PARAMS"
      puts params
      puts "*"*20
      # TODO: Throw error Letting user know that they need the be a publisher to publish a a game
      #       May be able to avoid this with blocking the page to users who arent publishers
      @publisher = current_user.publisher
      @game = @publisher.games.create(game_params)
      @game.save
      redirect_to game_path(@game)
    end
  end

  private

  def game_params
    params.permit(:title, :genre, :price, :description)
  end
end