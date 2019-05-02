class KeyMailer < ApplicationMailer
  def new_key_email
    @user = params[:user]
    mail(to: @user.email, subject: 'You have a New Game Key!')
  end
end
