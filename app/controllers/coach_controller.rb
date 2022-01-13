class CoachController < ApplicationController
  before_action :current_coach

  ############# coach update profile #############
  def edit
    @coach = @current_coach
    @problems = Problem.all
  end

  def update
    @coach = @current_coach
    if @coach.update(updated_params)
      params[:coach][:problems]&.each do |problem|
        @coach.problems << Problem.find_by(title: problem)
      end
      redirect_to dashboard_coach_page_path(@coach.id)
    else
      render :edit
    end
  end

  def password_update
    @coach = @current_coach
  end

  def password_coach_update
    @coach = @current_coach
    if BCrypt::Password.new(@coach.password_digest) == params[:coach][:old_password]
      if @coach.update(password_updated_params)
        redirect_to dashboard_coach_page_path(@coach.id)
      else
        render :password_edit
      end
    else
      render :password_edit
    end
  end

  ############# coach navbar items #############
  def dashboard
    @coach = @current_coach
    @problems = @coach.problems
    @invitation = @coach.invitations
    @notifications = CoachNotification.where(coach_id: @coach.id)
    @recommendations = @coach.recommendations
    get_techniques_in_progress(@invitation)
    count_likes_on_techniques(@recommendations)
  end

  def coach_users
    @coach = @current_coach
    @notifications = CoachNotification.where.not(coach_id: @coach.id, user_id: nil)
    @count = Invitation.where(coach_id: @coach.id, status: 0).count
    @invitation = Invitation.where(coach_id: @coach.id)
    get_techniques_in_progress(@invitation)
  end

  def library
    @coach = @current_coach
    @problems = Problem.all
    @techniques = Technique.all
  end

  ############# coach technique items #############
  def technique_detail
    @coach = @current_coach
    @technique = Technique.find_by_id(params[:technique_id])
    @steps = Step.where(technique_id: @technique.id)
  end

  ############# coach library items #############
  def new
    @coach = @current_coach
    @users = @coach.invitations
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @coach = @current_coach
    @technique = Technique.find_by_id(params[:technique_id])
    users_names_list = params[:users].select! { |element| element&.size.to_i > 0 }
    users_names_list.each do |user_name|
      user = User.find_by(name: user_name)
      if Recommendation.find_by(user_id: user.id, technique_id: @technique.id).nil?
        Recommendation.create(user_id: user.id, coach_id: @coach.id, technique_id: @technique.id, status: 0, step: 0)
        UserNotification.create(body: "Coach #{@coach.name} recommended a Technique for you", user_id: user.id,
                                coach_id: @coach.id, status: 1)
      else
        flash[:warning] = "User #{user_name} is already passed this technique!"
      end
    end
    redirect_to coach_users_page_path
  end

  ############# coach users items #############
  def user_detail
    @coach = @current_coach
    @invitation = Invitation.find_by(user_id: params[:user_id])
    @recommendations = Recommendation.where(user_id: params[:user_id])
    @notifications = CoachNotification.where(coach_id: @coach.id, user_id: @invitation.user.id)
  end

  def confirm
    @invite = Invitation.find_by_id(params[:invite_id])
    UserNotification.create(body: "Coach #{@invite.coach.name} agreed to become your coach", user_id: @invite.user.id,
                            status: 1)
    CoachNotification.create(body: "You agreed to become a coach for a user #{@invite.user.name}",
                             coach_id: @invite.coach.id, user_id: @invite.user.id, status: 1)
    @invite.update(status: 1)
    redirect_to coach_users_page_path(Coach.find_by_id(session[:coach_id]))
  end

  def refuse
    @invite = Invitation.find_by_id(params[:invite_id])
    CoachNotification.create(body: "You have rejected #{@invite.user.name} invite", coach_id: @invite.coach.id,
                             user_id: @invite.user.id, status: 1)
    UserNotification.create(body: "Coach #{@invite.coach.name} refused to become your coach", user_id: @invite.user.id,
                            coach_id: @invite.coach.id, status: 1)
    @invite.destroy
    redirect_to coach_users_page_path(Coach.find_by_id(session[:coach_id]))
  end

  private

  def get_techniques_in_progress(invitation)
    @user_data = {}
    invitation.each do |data|
      @user_data[data.user.name] = []
      user_recommendations = data.user.recommendations
      user_recommendations.each do |recommendation|
        @user_data[data.user.name] << recommendation.technique.title if recommendation.status == 'in_progress'
      end
      @user_data[data.user.name] << 'All techniques completed' if @user_data[data.user.name] == []
    end
  end

  def count_likes_on_techniques(recommendations)
    techniques_ids = []
    total_likes = 0
    recommendations.each do |data|
      techniques_ids << data.technique_id
    end
    techniques_ids.uniq!
    techniques_ids.each { |id| total_likes += Rating.where(technique_id: id).sum(:like) }
    total_likes
  end

  def updated_params
    params.require(:coach).permit(:name, :email, :avatar, :about, :age, :gender, :experience, :licenses, :socials,
                                  :education)
  end

  def password_updated_params
    params.require(:coach).permit(:password, :password_confirmation)
  end
end
