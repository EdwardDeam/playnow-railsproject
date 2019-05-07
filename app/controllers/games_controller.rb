class GamesController < ApplicationController
  # load_and_authorize_resource
  # skip_authorize_resource :only => [:new, :create]
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @total = @game.price
    @price_string = @game.price_to_string
  end

  def new
    unless current_user.publisher.nil?
      @game = Game.new
    end
  end

  def create
    unless current_user.publisher.nil?
      @publisher = current_user.publisher
      @game = @publisher.games.new(game_params)
      @game.save

      # TODO: New_Key_Email?? This function is for the creation of a game
      #       Should this be a different template??
      # KeyMailer.with(user: current_user).new_key_email.deliver_now
      redirect_to game_path(@game)
    end
  end

  def edit
    @game = Game.find(params[:id])
    @price_decimal = @game.price_to_decimal
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
    @game.set_unactive
    @game.save
    redirect_to dashboard_path
  end

  private   

  def game_params
    sanitize_price
    params.require(:game).permit(:title, :genre, :price, :description, images: [])
  end

  def price_from_decimal(decimal_price)
    # decimal_price will most likely be a string
    (decimal_price.to_f * 100.0).to_i
  end

  def sanitize_price
    # If the price being passed in is a demimal or float, convert it to a whole number.
    # Prices are stored in cents in the database.
    if params[:game][:price].class != Integer
      params[:game][:price] = price_from_decimal(params[:game][:price])
    end
  end
end
