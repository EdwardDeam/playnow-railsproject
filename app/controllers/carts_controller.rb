class CartsController < ApplicationController
  def index
    # TODO: Build a function to eager laod these
    @cart_items = current_user.cart.cart_items
    Debug.console(@cart_items.class.to_s)
    Debug.console(@cart_items[0].class.to_s)
  end

  def new
    # Add a check so this page cant just be loaded
    CartItem.create(cart: current_user.cart, game_id: cart_params[:game_id])
  end

  def create
    # game = Game.find(params[:game_id])
    # Debug.console(params.to_s)

    # CartItem.create(cart: current_user.cart, game: params[:game])
  end

  private
  def cart_params
    params.permit(:game_id)
  end
  # def game_params
  #   params.require(:game)
  #   # .permit(:title, :genre, :price, :description, :images)
  # end
end
