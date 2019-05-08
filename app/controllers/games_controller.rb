class GamesController < ApplicationController
  load_and_authorize_resource
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
    # Users that are not sellers cannot publish games
    unless current_user.publisher.nil?
      @game = Game.new
    end
  end

  def create
    # Users that are not sellers cannot publish games
    unless current_user.publisher.nil?
      @publisher = current_user.publisher
      @game = @publisher.games.new(game_params)
      @game.save
      # TODO: ADD MAILER
      GameMailer.with([user: current_user, @game.title]).published_email.deliver_now
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
    # Games are not removed from the database.
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

  # Convert a dollar value into a cent value
  def price_from_decimal(decimal_price)
    # decimal_price will most likely be a string from params
    (decimal_price.to_f * 100.0).to_i
  end

  def sanitize_price
    # The price being passed in will be a demimal or float, convert it to a whole
    # number. Prices are stored in cents in the database.
    if params[:game][:price].class != Integer
      params[:game][:price] = price_from_decimal(params[:game][:price])
    end
  end
end
