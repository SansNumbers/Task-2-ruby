class TechniqueController < ApplicationController
  before_action :current_user

  def techniques
    @recommendations = Recommendation.where(user_id: current_user.id)
    @invite = Invitation.find_by(user_id: current_user.id)
  end

  def restart
    @recommendation = Recommendation.find_by(user_id: current_user.id, technique_id: params[:technique_id]).update(step: 0,
                                                                                                                   status: 0)
    redirect_to technique_detail_user_path(technique_id: params[:technique_id], step_id: 0)
  end

  def rate
    respond_to do |format|
      format.html
      format.js
    end
  end

  def like
    unless Rating.exists?(technique_id: params[:technique_id], user_id: current_user.id)
      Rating.create(technique_id: params[:technique_id], user_id: current_user.id, like: 1, dislike: 0)
      UserNotification.create(body: 'You liked your Technique', user_id: current_user.id, status: 1)
    end

    recommendation = Recommendation.find_by(technique_id: params[:technique_id], user_id: current_user.id)
    # status = 2, because technique is completed (watch models/recommendation.rb)
    recommendation.update(status: 2)
    recommendation.update(ended_at: Time.zone.now) if recommendation.ended_at.nil?
    flash[:info] = 'You liked Technique'
    redirect_to user_dashboard_page_path
  end

  def dislike
    unless Rating.exists?(technique_id: params[:technique_id], user_id: current_user.id)
      Rating.create(technique_id: params[:technique_id], user_id: current_user.id, like: 0, dislike: 1)
      UserNotification.create(body: 'You disliked your Technique', user_id: current_user.id, status: 1)
    end

    recommendation = Recommendation.find_by(technique_id: params[:technique_id], user_id: current_user.id)
    # status = 2, because technique is completed (watch models/recommendation.rb)
    recommendation.update(status: 2)
    recommendation.update(ended_at: Time.zone.now) if recommendation.ended_at.nil?
    flash[:info] = 'You disliked Technique'
    redirect_to user_dashboard_page_path
  end
end
