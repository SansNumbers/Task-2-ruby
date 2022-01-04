class UserMailer < ApplicationMailer
  default from: 'somersetisfine@gmail.com'

  def welcome_email(user)
    @user = user
    @token = @user.signed_id(purpose: 'sign_up_verification', expires_in: 15.minutes)
    mail(to: @user.email, subject: 'Verify your email!')
  end
end
