class Publisher < ApplicationRecord
  belongs_to :user
  has_many :games, dependent: :delete_all
  has_many :orders
end
