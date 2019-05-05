class CartsController < ApplicationController
  def index
    cart_id = current_user.cart.id
    @cart_items = CartItem.find(cart_id: cart_id)
  end
end
