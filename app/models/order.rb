class Order < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :publisher

  # Callback to add a game key to the order
  after_create :generate_key

  private
  def generate_key
    # Array of random chars
    chars = [*'A'..'Z', *'0'..'9']
    key = ''
    20.times do |i|
      key += '-' if i % 5 == 0 && i != 0
      key += chars.sample
    end
    self.game_key = key
  end
end
