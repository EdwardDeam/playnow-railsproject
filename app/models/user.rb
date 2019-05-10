# All users of the platform will be a User object, With an optional attached
# publisher for selling games. Every User will have a cart to store games
# for purchase.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :publisher
  has_one :cart
  has_one_attached :avatar, dependent: :destroy
  has_many :orders
  # Allow description to be called directly from the user
  delegate :description, to: :publisher

  # Attach a publisher object if the user is a seller
  after_create :create_publisher, if: :seller
  # Give every user an order cart
  after_create :create_cart

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  private

  # Creates a Publisher object so that users can creaet and manage Games.
  def create_publisher
    pub = Publisher.new(description: 'Your description goes here!', user: self)
    pub.save
  end

  # Creates a Cart object so that users can store Games (through CartItem)
  # for later purchase
  def create_cart
    cart = Cart.new(user: self)
    cart.save
  end
end
