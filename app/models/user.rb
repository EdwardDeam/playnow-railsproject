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
  after_create :create_publisher, if: :seller

  private

  def create_publisher
    pub = Publisher.new(description: 'Your description goes here!', user: self)
    pub.save
  end
end
