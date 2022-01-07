class CoachController < ApplicationController
  before_action :check_coach!

  def show
    @coach = Coach.find_by_id(session[:coach_id])
  end

  def edit
    @coach = Coach.find_by_id(session[:coach_id])
    @problems = Problem.all
  end

  def update
    @coach = Coach.find(session[:coach_id])
    if @coach.update(updated_params)
      params[:coach][:problems]&.each do |problem|
        @coach.problems << Problem.find_by(title: problem)
      end
      redirect_to coach_page_path(@coach.id)
    else
      render :edit
    end
  end

  def password_update
    @coach = Coach.find(session[:coach_id])
  end

  def password_coach_update
    @coach = Coach.find(session[:coach_id])
    if BCrypt::Password.new(@coach.password_digest) == params[:coach][:old_password]
      if @coach.update(password_updated_params)
        redirect_to coach_page_path(@coach.id)
      else
        render :password_edit
      end
    else
      render :password_edit
    end
  end

  private

  def updated_params
    params.require(:coach).permit(:name, :email, :avatar, :about, :age, :gender, :experience, :licenses, :socials,
                                  :education)
  end

  def password_updated_params
    params.require(:coach).permit(:password, :password_confirmation)
  end
end
