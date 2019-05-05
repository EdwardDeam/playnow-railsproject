class AddCartItemsToCarts < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :carts, foreign_key: true
    add_reference :carts, :cart_items, foreign_key: true
  end
end
