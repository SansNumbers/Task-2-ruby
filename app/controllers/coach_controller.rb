class CoachController < ApplicationController
  before_action :check_coach!

  def dashboard
    @coach = Coach.find_by_id(session[:coach_id])
    @problems = @coach.problems
    @notifications = CoachNotification.where(coach_id: @coach.id)
    @invitation = Invitation.where(coach_id: @coach.id, status: 1)
    @recommendations = Recommendation.where(coach_id: @coach.id)
    get_techniques_in_progress(@invitation)
  end

  def coach_users
    @coach = Coach.find_by_id(session[:coach_id])
    @notifications = CoachNotification.where.not(coach_id: @coach.id, user_id: nil)
    @count = Invitation.where(coach_id: @coach.id, status: 0).count
    @invitation = Invitation.where(coach_id: @coach.id)
    get_techniques_in_progress(@invitation)
  end

  def confirm
    @invite = Invitation.find_by_id(params[:invite_id])
    UserNotification.create(body: "Coach #{@invite.coach.name} agreed to become your coach", user_id: @invite.user.id, status: 1)
    CoachNotification.create(body: "You agreed to become a coach for a user #{@invite.user.name}", coach_id: @invite.coach.id, user_id: @invite.user.id, status: 1)
    @invite.update(status: 1)
    redirect_to coach_users_page_path(Coach.find_by_id(session[:coach_id]))
  end

  def refuse
    @invite = Invitation.find_by_id(params[:invite_id])
    CoachNotification.create(body: "You have rejected #{@invite.user.name} invite", coach_id: @invite.coach.id, user_id: @invite.user.id, status: 1)
    UserNotification.create(body: "Coach #{@invite.coach.name} refused to become your coach", user_id: @invite.user.id, coach_id: @invite.coach.id, status: 1)
    @invite.destroy
    redirect_to coach_users_page_path(Coach.find_by_id(session[:coach_id]))
  end

  def library
    @coach = Coach.find_by_id(session[:coach_id])
    @problems = Problem.all
    @techniques = Technique.all
  end

  def technique_detail
    @coach = Coach.find_by_id(session[:coach_id])
    @technique = Technique.find_by_id(params[:technique_id])
    @steps = Step.where(technique_id: @technique.id)
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

  def get_techniques_in_progress(invitation)
    @user_data = {}
    invitation.each do |data|
      @user_data[data.user.name] = []
      user_recommendations = data.user.recommendations
      user_recommendations.each do |recommendation|
        if recommendation.status == 'in_progress'
          @user_data[data.user.name] << recommendation.technique.title
        end
      end
      @user_data[data.user.name] << "All techniques completed" if @user_data[data.user.name] == []
    end
  end

  def updated_params
    params.require(:coach).permit(:name, :email, :avatar, :about, :age, :gender, :experience, :licenses, :socials,
                                  :education)
  end

  def password_updated_params
    params.require(:coach).permit(:password, :password_confirmation)
  end
end
