# Addon for User class, Allows the User to publish ad manage Games that they
# have created.
class Publisher < ApplicationRecord
  belongs_to :user
  has_many :games
  has_many :orders
end
