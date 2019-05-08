class CartController < ApplicationController
  def index
    @cart_items = load_cart
    @total = cart_total
    @price_string = total_to_string
  end

  def new
    game = Game.find(cart_params[:game_id])
    CartItem.create(cart: current_user.cart, game: game)
  end

  def destroy
    item = CartItem.find(params[:id])
    item.destroy unless item.nil?
    redirect_to cart_index_path
  end

  def create
  end

  private

  # Paramaters that are allowed to be sent through
  def cart_params
    params.permit(:game_id)
  end

  # Total cost of all items in the cart
  def cart_total
    sum = 0
    @cart_items.each do |item|
      sum += item.game.price
    end
    return sum
  end

  # Loads all items from the Cart and also return the asssitated Games to lower
  # Database calls.
  def load_cart
    current_user.cart.cart_items.includes(:game)
  end

  # Returns the total as a deciaml with a '$'
  def total_to_string
    '$' + (@total / 100).to_s
  end
end
