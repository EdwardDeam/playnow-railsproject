class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :publisher, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders
  # Allow description to be called directly from the user
  delegate :description, to: :publisher
  # Attach a publisher object if the user is a seller
  after_create :create_publisher, if: :seller, on: :create
  # Give every user an order cart
  after_create :create_cart, on: :create

  private

  def create_publisher
    pub = Publisher.new(description: 'Your description goes here!', user: self)
    pub.save
  end

  def create_cart
    cart = Cart.new(user: self)
    cart.save
  end
end
