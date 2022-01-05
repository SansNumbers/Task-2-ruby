class UserMailer < ApplicationMailer
  def welcome_email
    @token = params[:user].signed_id(purpose: 'sign_up_user_verification', expires_in: 15.minutes)
    mail(to: params[:user].email, subject: 'Verify your email!')
  end
end
