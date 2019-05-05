class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :publisher, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders
  delegate :description, to: :publisher
  # validates :age_restriction

  # def age_restriction
  #   if (birth_date.to_date + 13.years) < Date.strptime
  #     errors.add :birth_date, 'Sorry but you need to be over 13 to agree to the Terms & Conditions'
  #   end
  # end
end
