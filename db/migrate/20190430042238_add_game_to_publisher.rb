class AddGameToPublisher < ActiveRecord::Migration[5.2]
  def change
    add_reference :publishers, :game, foreign_key: true
  end
end
