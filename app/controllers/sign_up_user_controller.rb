class SignUpUserController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.with(user: @user).welcome_email_user.deliver_now

      puts 'here'
      puts session[:user_id]
      puts 'here'

      render :create
    else
      render :index
    end
  end

  def edit
    puts 'here'
    puts session[:user_id]
    puts 'here'
    @problems = Problem.all
    @user = User.find_signed!(params[:token], purpose: 'sign_up_user_verify')
    puts 'here'
    puts session[:user_id]
    puts 'here'
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_up_user_verification_path, alert: 'Your token has expired. Please try again.'
  end

  def update
    @user = User.find_by(id: session[:user_id]) if session[:user_id]
    if @user.update(updated_params)
      params[:user][:problems]&.each do |problem|
        @user.problems << Problem.find_by(title: problem)
      end
      redirect_to user_page_path
    else
      render :edit
    end
  end

  def resend
    @user = User.find_by_id(session[:user_id]) if session[:user_id]
    UserMailer.with(user: @user).welcome_email_user.deliver_now
    render :create
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def updated_params
    params.require(:user).permit(:user_avatar, :age, :gender)
  end
end
