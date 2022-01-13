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
    session[:coach_id] = @coach.id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_up_coach_verification_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @coach = Coach.find(session[:coach_id])
    if @coach.update(updated_params)
      params[:coach][:problems]&.each do |problem|
        @coach.problems << Problem.find_by(title: problem)
      end
      redirect_to dashboard_coach_page_path(@coach.id)
    else
      render :edit
    end
  end

  def resend
    @coach = Coach.find(session[:coach_id]) if session[:coach_id]
    UserMailer.with(coach: @coach).welcome_email_coach.deliver_now
    render :create
  end

  private

  def coach_params
    params.require(:coach).permit(:name, :email, :password, :password_confirmation)
  end

  def updated_params
    params.require(:coach).permit(:avatar, :age, :gender, :education, :experience, :licenses, :socials)
  end
end
