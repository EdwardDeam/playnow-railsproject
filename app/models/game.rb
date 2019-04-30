class Game < ApplicationRecord
  belongs_to :publisher
  has_many :orders
end
