class UserController < ApplicationController
  before_action :check_user!

  def show
    @user = User.find_by_id(session[:user_id])
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
        redirect_to user_page_path(@user.id)
      else
        render :password_edit
      end
    else
      render :password_edit
    end
  end

  private

  def updated_params
    params.require(:user).permit(:name, :email, :avatar, :about, :age, :gender)
  end

  def password_updated_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
