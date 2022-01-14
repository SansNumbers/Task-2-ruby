class LibraryController < ApplicationController
  before_action :current_coach

  def library
    @coach = @current_coach
    @problems = Problem.all
    @techniques = Technique.all
    
  end

  def new
    @coach = @current_coach
    @users = @coach.invitations
    respond_to do |format|
      format.html
      format.js
    end
  end

  def technique_detail
    @coach = @current_coach
    @technique = Technique.find_by_id(params[:technique_id])
    @steps = Step.where(technique_id: @technique.id)
  end

  def create
    @coach = @current_coach
    @technique = Technique.find_by_id(params[:technique_id])
    users_names_list = params[:users].select! { |element| element&.size.to_i > 0 }
    users_names_list.each do |user_name|
      user = User.find_by(name: user_name)
      unless Recommendation.exists?(user_id: user.id, technique_id: @technique.id)
        Recommendation.create(user_id: user.id, coach_id: @coach.id, technique_id: @technique.id, status: 0, step: 0)
        UserNotification.create(body: "Coach #{@coach.name} recommended a Technique for you!", user_id: user.id, coach_id: @coach.id, status: 1)
      else
        flash[:warning] = "User #{user_name} is already passed this technique!"
      end
    end
    redirect_to coach_users_page_path
  end
end
