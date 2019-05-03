class AddPublisherFlagToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :seller, :boolean
  end
end
