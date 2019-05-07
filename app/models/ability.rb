# frozen_string_literal: true

# Definitions of performable actions based on user type and ID
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.seller?
      # Only sellers can add games to the platform
      can [:create, :read], Game
      # Sellers can only edit and destroy games they created
      can [:update, :delete], Game, owner: user.id
    end
    # Users can only view their own carts
    can :manage, CartItem, owner: user.id
    can :read, Cart, owner: user.id
  end
end
