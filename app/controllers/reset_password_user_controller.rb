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
    session[:user_id] = @user.id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to reset_password_edit_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @user = @current_user
    if @user.update(updated_params)
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

  def updated_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
