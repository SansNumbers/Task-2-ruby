class SignInCoachController < ApplicationController
  def index; end

  def create
    coach = Coach.find_by(email: params[:email])
    if coach.present? && coach.authenticate(params[:password])
      session[:coach_id] = coach.id
      redirect_to coach_page_path(coach.id), notice: 'Sign in successfull'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :index
    end
  end

  def logout
    session[:coach_id] = nil if session[:coach_id]
    redirect_to root_path
  end
end
