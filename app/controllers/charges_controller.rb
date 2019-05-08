class ChargesController < ApplicationController
  def new
  end

  # Buy now is called if the User want to purchase a single game.
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
    # After the paymen is successful Create an Order to store the information.
    order = Order.create(user: @user, publisher: @game.publisher, game: @game)
    
    GameMailer.with(user: current_user, key: order.game_key).new_key_email.deliver_now
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
      order = Order.create(user: current_user, publisher: item.game.publisher, game: item.game)
      GameMailer.with(user: current_user, key: order.game_key).new_key_email.deliver_now
      CartItem.delete(item.id)
    end
    redirect_to new_charge_path
  end
end
