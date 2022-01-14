class InvitationController < ApplicationController
  before_action :current_user

  def send_invitation
    @user = @current_user
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
      redirect_to user_coaches_page_path
    end
  end

  def cancel_invite
    @invite = Invitation.find_by_id(params[:invite_id])
    UserNotification.create(body: "You have canceled an invitation to coach #{@invite.coach.name}",
                            user_id: @invite.user.id, coach_id: @invite.coach.id, status: 1)
    @invite.destroy
    redirect_to user_dashboard_page_path(User.find(session[:user_id]))
  end

  def modal_end_cooperation
    @coach = Invitation.find_by(@current_user, status: 1).coach
    @invite = Invitation.find_by(@current_user)
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
    redirect_to user_dashboard_page_path(@current_user)
  end

  def coach_info
    @coach = Coach.find_by(id: params[:coach_id])
    @invite = Invitation.find_by(user_id: User.find(session[:user_id]))
    respond_to do |format|
      format.html
      format.js
    end
  end
end
