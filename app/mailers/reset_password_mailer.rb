class ResetPasswordMailer < ApplicationMailer
  def reset_password_user
    @token = params[:user].signed_id(purpose: 'reset_password_user_verify', expires_in: 15.minutes)
    mail(to: params[:user].email, subject: 'Reset password!')
  end

  def reset_password_coach
    @token = params[:coach].signed_id(purpose: 'reset_password_coach_verify', expires_in: 15.minutes)
    mail(to: params[:coach].email, subject: 'Reset password!')
  end
end
