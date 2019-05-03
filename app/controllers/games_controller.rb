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

      @user = current_user
      KeyMailer.with(user: @user).new_key_email.deliver_now
      redirect_to game_path(@game)
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
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
    sanitize_price
    params.require(:game).permit(:title, :genre, :price, :description, :images)
  end

  def price_from_decimal(decimal_price)
    decimal_price = decimal_price.to_f
    (decimal_price * 100).to_i
  end

  def sanitize_price
    if params[:game][:price].class != Integer
      return params[:game][:price] = price_from_decimal(params[:game][:price])
    end
  end
end
