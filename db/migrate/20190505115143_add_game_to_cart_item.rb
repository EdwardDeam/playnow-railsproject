class AddGameToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :games, foreign_key: true
  end
end
