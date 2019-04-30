class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.string :genre
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
