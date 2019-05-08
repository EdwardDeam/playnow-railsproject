class GameMailer < ApplicationMailer
  def new_key_email
    @user = params[:user]
    @key = params[:key]
    mail(to: @user.email, subject: 'You have a New Game Key!')
  end

  def published_email
    @user = params[:user]
    @game = params[:game]
    mail(to: @user.email, subject: 'You have published a new Game!')
  end
end
