class Order < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :publisher
end
