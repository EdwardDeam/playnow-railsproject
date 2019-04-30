class FixReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :publisher, foreign_key: true
    add_reference :publishers, :user, foreign_key: true
    remove_column :publishers, :game_id
    remove_column :users, :publisher_id
  end
end
