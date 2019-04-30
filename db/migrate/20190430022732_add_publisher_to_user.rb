class AddPublisherToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :publisher, foreign_key: true
  end
end
