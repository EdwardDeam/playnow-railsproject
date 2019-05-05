class CartsController < ApplicationController
  def index
    @cart_id = current_user.cart.id
    @cart_items = CartItem.find(cart_id: cart_id)
  end

  def new
    puts params
    Debug.console(params.to_s)
    # raise
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
