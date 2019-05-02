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
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

    order = Order.create({user: current_user, publisher: @game.owner, game: @game})
    puts "*"*20
    puts order
    puts Orders.last
    puts "*"*20

    # Order.create({user: regular1, publisher: pub1_obj, game: pub1_obj.games.first, game_key: 'AAAAAAAAA'}),
  end
end
