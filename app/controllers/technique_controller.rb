class TechniqueController < ApplicationController
  before_action :current_user

  def techniques
    @user = @current_user
    @recommendations = Recommendation.where(user_id: @user.id)
    @invite = Invitation.find_by(user_id: @user.id)
  end

  def restart
    @user = @current_user
    @recommendation = Recommendation.find_by(user_id: @user.id, technique_id: params[:technique_id]).update(step: 0,
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
    @user = @current_user

    if Rating.find_by(technique_id: params[:technique_id], user_id: @user.id).nil?
      Rating.create(technique_id: params[:technique_id], user_id: @user.id, like: 1, dislike: 0)
      UserNotification.create(body: 'You liked your Technique', user_id: @user.id, status: 1)
    end

    recommendation = Recommendation.find_by(technique_id: params[:technique_id], user_id: @user.id)
    recommendation.update(status: 2)
    recommendation.update(ended_at: Time.zone.now) if recommendation.ended_at.nil?
    flash[:info] = 'You liked Technique'
    redirect_to user_dashboard_page_path
  end

  def dislike
    @user = @current_user

    if Rating.find_by(technique_id: params[:technique_id], user_id: @user.id).nil?
      Rating.create(technique_id: params[:technique_id], user_id: @user.id, like: 0, dislike: 1)
      UserNotification.create(body: 'You dislike your Technique', user_id: @user.id, status: 1)
    end

    recommendation = Recommendation.find_by(technique_id: params[:technique_id], user_id: @user.id)
    recommendation.update(status: 2)
    recommendation.update(ended_at: Time.zone.now) if recommendation.ended_at.nil?
    flash[:info] = 'You disliked Technique'
    redirect_to user_dashboard_page_path
  end
end
