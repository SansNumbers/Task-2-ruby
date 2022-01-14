class UserController < ApplicationController
  layout 'user'
  before_action :current_user

  def edit
    @user = @current_user
    @problems = Problem.all
  end

  def update
    @user = @current_user
    if @user.update(updated_params)
      params[:user][:problems]&.each do |problem|
        @user.problems << Problem.find_by(title: problem)
      end
      UserNotification.create(body: 'You changed your profile settings', status: 1, user_id: @user.id)
      redirect_to user_dashboard_page_path(@user.id)
    else
      render :edit
    end
  end

  def password_update
    @user = @current_user
  end

  def password_user_update
    if BCrypt::Password.new(@user.password_digest) == params[:user][:old_password]
      if @user.update(password_updated_params)
        UserNotification.create(body: 'You changed your password settings', status: 1, user_id: @user.id)
        redirect_to user_dashboard_page_path(@user.id)
      else
        render :password_edit
      end
    else
      render :password_edit
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
