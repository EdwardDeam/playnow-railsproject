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
  # validates :age_restriction

  def create_publisher
    pub = Publisher.new(description: 'Your description goes here!', user: self)
    pub.save
  end

   def create_cart
    cart = Cart.new(user: self)
    cart.save
  end

  # def age_restriction
  #   if (birth_date.to_date + 13.years) < Date.strptime
  #     errors.add :birth_date, 'Sorry but you need to be over 13 to agree to the Terms & Conditions'
  #   end
  # end
end
