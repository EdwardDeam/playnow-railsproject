class CartController < ApplicationController
  def index
    @cart_items = load_cart
    @total = cart_total
    @price_string = total_to_string
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

  def cart_total
    sum = 0
    @cart_items.each do |item|
      sum += item.game.price
    end
    return sum
  end

  def load_cart
    # current_user.cart.cart_items.includes(:game)
    current_user.cart.cart_items.includes(:game)
  end

  def total_to_string
    '$' + (@total / 100).to_s
  end
end