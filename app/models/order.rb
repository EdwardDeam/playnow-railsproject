class Order < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :publisher

  # Callback to add a game key to the order
  before_create :generate_key

  private
  def generate_key
    # Array of characters to sample
    chars = [*'A'..'Z', *'0'..'9']
    key = ''
    20.times do |i|
      # put a dash every 5 characters except the first one
      key += '-' if i % 5 == 0 && i != 0
      key += chars.sample
    end
    self.game_key = key
  end
end
