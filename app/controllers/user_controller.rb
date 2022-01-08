class UserController < ApplicationController
  before_action :check_user!

  def dashboard
    @user = User.find(session[:user_id])
    @problems = @user.problems
    @notifications = UserNotification.where(user_id: @user.id)
    @invite = Invitation.find_by(user_id: @user.id)
    @recommendations = Recommendation.where(user_id: @user.id).order(:status)
  end

  def new
    @coach = Coach.find_by(id: params[:coach_id])
    @invite = Invitation.find_by(user_id: User.find_by_id(session[:user_id]))
    respond_to do |format|
      format.html
      format.js
    end
  end

  def finish
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = User.find_by_id(session[:user_id])
    @problems = Problem.all
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(updated_params)
      params[:user][:problems]&.each do |problem|
        @user.problems << Problem.find_by(title: problem)
      end
      UserNotification.create(body: 'You changed your profile settings', status: 1, user_id: @user.id)
      redirect_to user_page_path(@user.id)
    else
      render :edit
    end
  end

  def password_update
    @user = User.find(session[:user_id])
  end

  def password_user_update
    @user = User.find(session[:user_id])
    if BCrypt::Password.new(@user.password_digest) == params[:user][:old_password]
      if @user.update(password_updated_params)
        UserNotification.create(body: 'You changed your password settings', status: 1, user_id: @user.id)
        redirect_to user_page_path(@user.id)
      else
        render :password_edit
      end
    else
      render :password_edit
    end
  end

  def coaches_page
    @user = User.find(session[:user_id])
    @coahes = Coach.all
    @problems = Problem.all
    @invite = Invitation.find_by(user_id: @user.id)
    if !params[:search].nil?
      search_coach(params[:search])
    else
      filter_coach(params[:filter])
    end
  end

  def techniques
    @user = User.find(session[:user_id])
    @recommendations = Recommendation.where(user_id: @user.id)
    @invite = Invitation.find_by(user_id: @user.id)
  end

  def user_technique_detail
    @user = User.find(session[:user_id])
    @technique = Technique.find_by_id(params[:technique_id])
    @recommendation = Recommendation.find_by(user_id: @user.id, technique_id: params[:technique_id])
    next_step = params[:step_id].to_i
    if @recommendation.step + 1 <= @technique.total_steps
      @recommendation.update(step: next_step + 1, status: 1)
      @recommendation.update(started_at: Time.zone.now) if @recommendation.started_at.nil?
      @step = Step.find_by(number: next_step + 1)
    end
  end

  def restart
    @user = User.find(session[:user_id])
    @recommendation = Recommendation.find_by(user_id: @user.id, technique_id: params[:technique_id]).update(step: 0,
                                                                                                            status: 0)
    redirect_to user_technique_detail_path(technique_id: params[:technique_id], step_id: 0)
  end

  def send_invintation
    @user = User.find(session[:user_id])
    @coach = Coach.find_by_id(params[:coach_id])
    if Invitation.find_by(user_id: @user.id).nil?
      Invitation.create(coach_id: @coach.id, user_id: @user.id, status: 0)
      UserNotification.create(body: "You have sent an invitation to coach #{@coach.name}", user_id: @user.id,
                              coach_id: @coach.id, status: 1)
      CoachNotification.create(body: "You have received an invitation to become a coach from a user #{@user.name}",
                               coach_id: @coach.id, user_id: @user.id, status: 1)
      redirect_to user_dashboard_page_path, notice: 'You have sent an invitation to coach!'
    else
      flash[:alert] = 'First, cancel the invitation to another coach!'
      redirect_to user_coahes_page_path
    end
  end

  def cancel_invite
    @invite = Invitation.find_by_id(params[:invite_id])
    UserNotification.create(body: "You have canceled an invitation to coach #{@invite.coach.name}",
                            user_id: @invite.user.id, coach_id: @invite.coach.id, status: 1)
    @invite.destroy
    redirect_to user_dashboard_page_path(Current.user.id)
  end

  def modal_ask_form
    @coach = Invitation.find_by(user_id: User.find(session[:user_id]), status: 1).coach
    @invite = Invitation.find_by(user_id: User.find(session[:user_id]))
    respond_to do |format|
      format.html
      format.js
    end
  end

  def end_cooperation
    @invite = Invitation.find_by_id(params[:invite_id])
    UserNotification.create(body: "You have ended cooperation with coach #{@invite.coach.name}",
                            user_id: @invite.user.id, coach_id: @invite.coach.id, status: 1)
    @invite.destroy
    redirect_to user_dashboard_page_path(Current.user.id)
  end

  private

  def search_coach(param)
    @coaches = Coach.search(param)
  end

  def filter_coach(filter_params)
    @coaches = Coach.where(nil)

    if filter_params
      @coaches = Problem.find_by(name: filter_params[:problems]).coaches if filter_params[:problems].present?
      
      filter_params[:gender]&.each do |gender|
        @coaches = @coaches.where('gender = ?', 0) if gender == 'male'
        @coaches = @coaches.where('gender = ?', 1) if gender == 'female'
        @coaches = @coaches.where(nil) if gender == 'all'
      end
      
      filter_params[:gender]&.each do |gender|
        @coaches = @coaches.where('gender = ?', 0) if gender == 'male'
        @coaches = @coaches.where('gender = ?', 1) if gender == 'female'
        @coaches = @coaches.where(nil) if gender == 'all'
      end
      
      filter_params[:age]&.each do |age|
        @coaches = @coaches.where("age <= '25'") if age == '25'
        @coaches = @coaches.where("age > '25' and age < '35'") if age == '25-35'
        @coaches = @coaches.where("age > '35' and age < '45'") if age == '35-45'
        @coaches = @coaches.where("age >= '45'") if age == '45'
      end
    
    else
      @coaches = Coach.all
    end
  end

  def updated_params
    params.require(:user).permit(:name, :email, :avatar, :about, :age, :gender, :problem)
  end

  def password_updated_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
