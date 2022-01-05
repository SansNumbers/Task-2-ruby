class SignUpCoachController < ApplicationController
  def index
    @coach = Coach.new
  end

  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      session[:coach_id] = @coach.id
      UserMailer.with(coach: @coach).welcome_email_coach.deliver_now
      render :create
    else
      render :index
    end
  end

  def edit
    @problems = Problem.all
    @coach = Coach.find_signed!(params[:token], purpose: 'sign_up_coach_verify')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_up_coach_verification_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @coach = Coach.find_by(id: session[:coach_id]) if session[:coach_id]

    Coaches::EditProfileService.call(@coach, params)
    redirect_to sign_in_coach_path
  rescue ServiceError => e
    flash[:error] = e.message
    render :edit
  end

  def resend
    @coach = Coach.find_by_id(session[:coach_id]) if session[:coach_id]
    UserMailer.with(coach: @coach).welcome_email_coach.deliver_now
    render :create
  end

  def destroy
    Coach.find_by_id(session[:coach_id]).destroy if session[:coach_id]
    session[:coach_id] = nil
    redirect_to sign_up_coach_path
  end

  private

  def coach_params
    params.require(:coach).permit(:name, :email, :password, :password_confirmation)
  end
end
