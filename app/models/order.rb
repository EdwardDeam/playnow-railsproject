# Final storage of purchases, contains the parties involved in the transaction
# aswell as the product.
class Order < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :publisher

  # Add a game key to the order
  before_create :generate_key

  private

  # Generates a dash separarated string that will represent a game key
  def generate_key
    # Array of characters to sample from.
    chars = [*'A'..'Z', *'0'..'9']
    key = ''
    20.times do |i|
      # put a dash every 5 characters except the first one.
      key += '-' if (i % 5).zero? && i != 0
      key += chars.sample
    end
    # Set the orders game key to this.
    self.game_key = key
  end
end
