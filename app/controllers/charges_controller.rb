class ChargesController < ApplicationController
  def new
  end

  def create
    @game = Game.find(params[:game_id])
    @user = current_user
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    begin
    charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @game.price,
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
 
end
