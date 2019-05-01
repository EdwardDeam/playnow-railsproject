class Publisher < ApplicationRecord
  belongs_to :user
  has_many :games, dependent: :delete_all
  has_many :orders

  # Allow description to be called directly from the user
  delegate :description, to: :user
end
