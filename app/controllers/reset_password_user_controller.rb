class ResetPasswordUserController < ApplicationController
  def index; end

  def create
    @user = User.find_by(email: params[:email]) if params[:email]
    if @user
      ResetPasswordMailer.with(user: @user).reset_password_user.deliver_now
      render :create
    else
      render :index
    end
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'reset_password_user_verify')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_user_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'reset_password_user_verify')

    if @user.update(user_password_params)
      redirect_to sign_in_user_path
    else
      render :edit
    end
  end

  def resend
    @user = User.find_by(email: params[:email]) if params[:email]
    ResetPasswordMailer.with(user: @user).reset_password_user.deliver_now
    render :create
  end

  private

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
