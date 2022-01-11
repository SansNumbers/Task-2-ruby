class SignInUserController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_user_page_path(user.id), notice: 'Sign in successfull'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :index
    end
  end

  def logout
    session[:user_id] = nil if session[:user_id]
    redirect_to root_path
  end
end
