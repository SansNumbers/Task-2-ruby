class ResetPasswordCoachController < ApplicationController
  def index; end

  def create
    @coach = Coach.find_by(email: params[:email]) if params[:email]
    if @coach
      ResetPasswordMailer.with(coach: @coach).reset_password_coach.deliver_later
      render :create
    else
      render :index
    end
  end

  def edit
    @coach = Coach.find_signed!(params[:token], purpose: 'reset_password_coach_verify')
    session[:coach_id] = @coach.id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to reset_password_edit_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @coach = @current_coach
    if @coach.update(updated_params)
      redirect_to sign_in_coach_path
    else
      render :edit
    end
  end

  def resend
    @coach = Coach.find_by(email: params[:email]) if params[:email]
    ResetPasswordMailer.with(coach: @coach).reset_password_coach.deliver_later
    render :create
  end

  private

  def updated_params
    params.require(:coach).permit(:password, :password_confirmation)
  end
end
