class UserController < ApplicationController
  before_action :current_user

  def edit
    @problems = Problem.all
  end

  def update
    if current_user.update(updated_params)
      params[:user][:problems]&.each do |problem|
        current_user.problems << Problem.find_by(title: problem)
      end
      UserNotification.create(body: 'You changed your profile settings', status: 1, user_id: current_user.id)
      redirect_to user_dashboard_page_path(current_user.id)
    else
      render :edit
    end
  end

  def password_update; end

  def password_user_update
    if BCrypt::Password.new(@current_user.password_digest) == params[:user][:old_password]
      if @current_user.update(password_updated_params)
        UserNotification.create(body: 'You changed your password settings', status: 1, user_id: @current_user.id)
        redirect_to user_dashboard_page_path(@current_user.id)
      else
        render :password_update
      end
    else
      render :password_update
    end
  end

  private

  def updated_params
    params.require(:user).permit(:name, :email, :user_avatar, :about, :age, :gender, :problem)
  end

  def password_updated_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
