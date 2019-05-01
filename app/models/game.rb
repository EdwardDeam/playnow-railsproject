class Game < ApplicationRecord
  belongs_to :publisher
  has_many :orders
  has_many_attached :images
  def owner
    puts "*"*20
    puts "OWNER METHOD RUN"
    puts "*"*20
    publisher.user.id
  end
end
