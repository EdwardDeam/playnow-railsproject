class CartItem < ApplicationRecord
  belongs_to :cart
  has_one :game
end
s