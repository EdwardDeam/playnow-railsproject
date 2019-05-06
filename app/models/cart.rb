class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def owner
    # Return the user that this cart belongs to 
    user.id
  end
end
