class Game < ApplicationRecord
  belongs_to :publisher
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many_attached :images

  def owner
    # Returns the ID of the user that created this Game.
    publisher.user.id
  end

  def set_unactive
    self.active = false
  end

  # TODO: Check if these make one or two calls to the database
  #       Might be better to keep this in a controller or PORO
  def price_to_decimal
    price / 100.0
  end

  def price_to_string
    '$' + price_to_decimal.to_s
  end
end
