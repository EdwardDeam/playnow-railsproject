class CartItem < ApplicationRecord
  belongs_to :cart
  has_one :game

  def owner
    # Returns the ID of the user that this CartItem belongs to.
    cart.user.id
  end
end
