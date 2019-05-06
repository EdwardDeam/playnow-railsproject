class AddCartReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :user, foreign_key: true
    add_reference :cart_items, :cart, foreign_key: true
    add_reference :cart_items, :game, foreign_key: true
  end
end
