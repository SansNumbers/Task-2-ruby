class SignInUserController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    puts '------------'
    puts session[:user_id]
    puts '------------'
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_page_path(user.id), notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :index
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end