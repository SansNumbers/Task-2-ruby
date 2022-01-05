class UserMailer < ApplicationMailer
  def welcome_email_user
    @token = params[:user].signed_id(purpose: 'sign_up_user_verify', expires_in: 15.minutes)
    mail(to: params[:user].email, subject: 'Verify your email!')
  end

  def welcome_email_coach
    @token = params[:coach].signed_id(purpose: 'sign_up_coach_verify', expires_in: 15.minutes)
    mail(to: params[:coach].email, subject: 'Verify your email!')
  end
end
