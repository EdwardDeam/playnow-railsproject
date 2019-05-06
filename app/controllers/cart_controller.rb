class CartController < ApplicationController
  def index
    @cart_items = load_cart
  end

  def new
    game = Game.find(cart_params[:game_id])
    # CartItem.create(cart: current_user.cart, game: game)
    CartItem.create(cart: current_user.cart, game: game)
  end

  def create
  end

  private

  def cart_params
    params.permit(:game_id)
  end

  def load_cart
    # current_user.cart.cart_items.includes(:game)

    current_user.cart.cart_items
  end
end