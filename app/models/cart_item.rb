# CartItems are used to populate the Cart and store game items until the user
# decides to purchase them.
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :game

  # Returns the ID of the user that this CartItem belongs to.
  def owner
    cart.user.id
  end
end
