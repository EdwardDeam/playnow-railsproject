class GamesController < ApplicationController
  load_and_authorize_resource
  # skip_authorize_resource :only => [:new, :create]
  def index
    @games = Game.all
  end

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
      # TODO: Throw error Letting user know that they need the be a publisher to publish a a game
      #       May be able to avoid this with blocking the page to users who arent publishers
      @publisher = current_user.publisher
      @game = @publisher.games.new(game_params)
      @game.save
      redirect_to game_path(@game)
    end
  end

  def edit
    @game = Game.find(params[:id])

  end

  def update
    puts "*"*20
    puts 'PARAMS UPDATE'
    puts params
    puts "*"*20
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to @game
    else
      render :edit
    end
    
  end

  def destroy
    @game = Game.find(params[:id])
    # binding.pry
    @game.destroy
    redirect_to root_path
  end

  private

  def game_params
<<<<<<< HEAD
    params.require(:game).permit(:title, :genre, :price, :description)
=======
    params.permit(:title, :genre, :price, :description, images: [])
>>>>>>> bc12dafaf3042dfe424ff273bac944a45b8b80cc
  end
end