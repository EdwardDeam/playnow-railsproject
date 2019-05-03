class ChargesController < ApplicationController
  def new
  end

  def create
    @game = Game.find(params[:game_id])

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @game.price,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

  order = Order.create({user: current_user, publisher: @game.publisher, game: @game })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
