class UpdateCartRelations < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :game, foreign_key: true

    remove_column :games, :cart_item_id
  end
end
