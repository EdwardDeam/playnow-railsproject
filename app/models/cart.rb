# Connected to a user, holds the CartItems that they have added
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  # Return the user that this cart belongs to
  def owner
    user.id
  end
end
