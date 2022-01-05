class SignUpUserController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.with(user: @user).welcome_email.deliver_now
      render :create
    else
      render :index
    end
  end

  def edit
    @problems = Problem.all
    @user = User.find_signed!(params[:token], purpose: 'sign_up_user_verify')
  #rescue ActiveSupport::MessageVerifier::InvalidSignature
    #redirect_to sign_up_user_path, alert: 'Your token has expired. Please try again.'
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
    @user = User.find_by_id(session[:user_id]) if session[:user_id]
    UserMailer.with(user: @user).welcome_email.deliver_now
    render :create
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
