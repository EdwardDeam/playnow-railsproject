class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      
      t.timestamps
    end
    
    create_table :cart_items do |t|
      t.timestamps
    end
  end
end