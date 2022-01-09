class CoachController < ApplicationController
  before_action :check_coach!

  def dashboard
    @coach = Coach.find_by_id(session[:coach_id])
    @problems = @coach.problems
    @notifications = CoachNotification.where(coach_id: @coach.id)
    @invitation = Invitation.where(coach_id: @coach.id, status: 1)
    @recommendations = Recommendation.where(coach_id: @coach.id)
  end

  def coach_users
    @coach = Coach.find_by_id(session[:coach_id])
    @notifications = CoachNotification.where.not(coach_id: @coach.id, user_id: nil)
    @count = Invitation.where(coach_id: @coach.id, status: 0).count
    @invitation = Invitation.where(coach_id: @coach.id)
  end

  def library
    @coach = Coach.find_by_id(session[:coach_id])
    @problems = Problem.all
    @techniques = Technique.all
  end

  def show
    @coach = Coach.find_by_id(session[:coach_id])
  end

  def edit
    @coach = Coach.find_by_id(session[:coach_id])
    @problems = Problem.all
  end

  def update
    @coach = Coach.find(session[:coach_id])
    if @coach.update(updated_params)
      params[:coach][:problems]&.each do |problem|
        @coach.problems << Problem.find_by(title: problem)
      end
      redirect_to coach_page_path(@coach.id)
    else
      render :edit
    end
  end


  def password_update
    @coach = Coach.find(session[:coach_id])
  end

  def password_coach_update
    @coach = Coach.find(session[:coach_id])
    if BCrypt::Password.new(@coach.password_digest) == params[:coach][:old_password]
      if @coach.update(password_updated_params)
        redirect_to coach_page_path(@coach.id)
      else
        render :password_edit
      end
    else
      render :password_edit
    end
  end

  private

  def updated_params
    params.require(:coach).permit(:name, :email, :avatar, :about, :age, :gender, :experience, :licenses, :socials,
                                  :education)
  end

  def password_updated_params
    params.require(:coach).permit(:password, :password_confirmation)
  end
end
