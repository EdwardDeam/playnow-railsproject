class AddDefaultValueToActiveAttribute < ActiveRecord::Migration[5.2]
  def up
    change_column :games, :active, :boolean, default: true
  end
end
