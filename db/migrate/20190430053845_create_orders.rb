class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :game_key

      t.timestamps
    end
    add_reference :orders, :publisher, foreign_key: true
    add_reference :orders, :user, foreign_key: true
    add_reference :orders, :game, foreign_key: true
  end
end
