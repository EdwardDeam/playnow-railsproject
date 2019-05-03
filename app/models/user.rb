require_relative '../../bin/debug.rb'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :publisher, dependent: :destroy
  has_many :orders
  delegate :description, to: :publisher

  after_create :create_publisher
  # validates :age_restriction

  def create_publisher
    if seller
      pub = Publisher.new({description: 'asdsad', user: self})
      pub.save
      # Debug.console("CREATE_PUBLISHER", publisher.to_s)
    end

  end

  # def age_restriction
  #   if (birth_date.to_date + 13.years) < Date.strptime
  #     errors.add :birth_date, 'Sorry but you need to be over 13 to agree to the Terms & Conditions'
  #   end
  # end
end
