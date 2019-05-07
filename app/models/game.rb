# Base product of the platform, can be created by Publishers and purchased
# by Users.
class Game < ApplicationRecord
  belongs_to :publisher
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  # Returns the ID of the user that created this Game.
  def owner
    publisher.user.id
  end

  # Games are not 'deleted' form the system but are set to unactive in the
  # database this allows users to still access a game they have paid for if
  # the developer removes it.
  def set_unactive
    self.active = false
  end

  def set_active
    self.active = true
  end

  # Price is strored in cents in the database, this converts it into a
  # decimal number.
  def price_to_decimal
    price.to_f / 100.0
  end

  # Displays the price as a string with a '$' sign
  def price_to_string
    '$' + price_to_decimal.to_s
  end
end
