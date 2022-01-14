class DashboardController < ApplicationController
  before_action :current_user

  def dashboard
    @user = @current_user
    @problems = @user.problems
    @notifications = UserNotification.where(user_id: @user.id)
    @invite = Invitation.find_by(user_id: @user.id)
    @recommendations = Recommendation.where(user_id: @user.id).order(:status)
  end

  def technique_detail_user
    @user = @current_user
    @technique = Technique.find_by_id(params[:technique_id])
    @recommendation = Recommendation.find_by(user_id: @user.id, technique_id: params[:technique_id])

    next_step = params[:step_id].to_i

    if next_step < @technique.total_steps
      @recommendation.update(step: next_step + 1, status: 1)
      @recommendation.update(started_at: Time.zone.now) if @recommendation.started_at.nil?
      @step = Step.find_by(number: next_step + 1)
    else
      @recommendation.update(ended_at: Time.zone.now) if @recommendation.ended_at.nil?
      @step = Step.find_by(number: next_step)
      @recommendation.update(status: 2)
    end
  end

  def coaches
    @user = @current_user
    @coahes = Coach.all
    @problems = Problem.all
    @invite = Invitation.find_by(user_id: @user.id)
  end
end
