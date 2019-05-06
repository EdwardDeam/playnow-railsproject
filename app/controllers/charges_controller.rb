class ChargesController < ApplicationController
  def new
  end

  def buy_now
    @game = Game.find(params[:game_id])
    @user = current_user
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    begin
    charge = Stripe::Charge.create({
        customer: customer.id,
        amount: params[:amount],
        description: 'Rails Stripe customer',
        currency: 'usd',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to game_path(@game)
    end
    Order.create(user: @user, publisher: @game.publisher, game: @game)
    redirect_to new_charge_path
  end
  
  def buy_cart
    @cart = current_user.cart
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    begin
    charge = Stripe::Charge.create({
        customer: customer.id,
        amount: params[:amount],
        description: 'Rails Stripe customer',
        currency: 'usd',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to game_path(@game)
    end

    @cart.cart_items.each do |item|
      Order.create(user: current_user, publisher: item.game.publisher, game: item.game)
      CartItem.delete(item.id)
    end
    redirect_to new_charge_path
  end
end
