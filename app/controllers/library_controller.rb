class LibraryController < ApplicationController
  before_action :current_coach

  def library
    @problems = Problem.all
    @techniques = Technique.all
  end

  def new
    @users = current_coach.invitations
    respond_to do |format|
      format.html
      format.js
    end
  end

  def technique_detail
    @technique = Technique.find_by_id(params[:technique_id])
    @steps = Step.where(technique_id: @technique.id)
  end

  def create
    @technique = Technique.find_by_id(params[:technique_id])
    users_names_list = params[:users].select! { |element| element&.size.to_i > 0 }
    users_names_list.each do |user_name|
      user = User.find_by(name: user_name)
      if Recommendation.exists?(user_id: user.id, technique_id: @technique.id)
        flash[:warning] = "User #{user_name} is already passed this technique!"
      else
        Recommendation.create(user_id: user.id, coach_id: current_coach.id, technique_id: @technique.id, status: 0,
                              step: 0)
        UserNotification.create(body: "Coach #{current_coach.name} recommended a Technique for you!", user_id: user.id,
                                coach_id: current_coach.id, status: 1)
      end
    end
    redirect_to coach_users_page_path
  end
end
