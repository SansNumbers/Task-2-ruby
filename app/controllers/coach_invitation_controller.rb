class CoachInvitationController < ApplicationController
  before_action :current_coach

  def dashboard
    @problems = current_coach.problems
    @notifications = current_coach.coach_notifications
    @invitation = current_coach.invitations
    @recommendations = current_coach.recommendations
    @all_users = User.all.count
    @all_coach_users = current_coach.invitations.where(status: 1).count
    @techniques_used = Recommendation.where(coach_id: current_coach.id).count
    count_likes_on_techniques(@recommendations)
    get_techniques_in_progress(@invitation)
  end

  def user_detail
    user = User.find(params[:user_id])
    @invitation = Invitation.find_by(user_id: params[:user_id])
    @recommendations = Recommendation.where(user_id: params[:user_id])

    @notifications = current_coach.coach_notifications.with_user(user.id)
    @techniques_completed = Recommendation.completed.count
    @techniques_in_progress = Recommendation.in_progress.count
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

  def coach_users
    @notifications = CoachNotification.where.not(user_id: nil).where(coach_id: current_coach.id)
    @count = Invitation.where(coach_id: current_coach.id, status: 0).count
    @invitation = current_coach.invitations
    get_techniques_in_progress(@invitation)
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
    @total_likes = 0
    recommendations.each do |data|
      techniques_ids << data.technique_id
    end
    techniques_ids.uniq!
    techniques_ids.each { |id| @total_likes += Rating.where(technique_id: id).sum(:like) }
  end
end
