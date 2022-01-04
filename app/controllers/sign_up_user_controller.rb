class SignUpUserController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        UserMailer.welcome_email(@user).deliver_now
        session[:user_id] = @user.id
        render :create
      else
        render :new
      end
  end

  def edit
    @user = User.find_by(email: session[:email]) if session[:email]
  end

  def update
    @user = User.find_by(email: session[:email]) if session[:email]
    if params[:user][:verify_email] == $msg
      @user.verify_email = params[:user][:verify_email]
      session[:user_id] = @user.id if @user.save
      redirect_to user_page_path(@user.id), notice: 'Successfully created account'
    else
      render :edit
    end
  end

  def resend
    @user = User.find_by(email: session[:email]) if session[:email]
    $msg = rand(9).to_s + rand(9).to_s + rand(9).to_s + rand(9).to_s
    UserMailer.welcome_email(@user, $msg).deliver_now
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
