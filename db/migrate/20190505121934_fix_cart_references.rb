class FixCartReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :user, foreign_key: true
    add_reference :cart_items, :cart, foreign_key: true
    add_reference :games, :cart_item, foreign_key: true

    remove_column :users, :carts_id
    remove_column :carts, :cart_items_id
    remove_column :cart_items, :games_id

  end
end
