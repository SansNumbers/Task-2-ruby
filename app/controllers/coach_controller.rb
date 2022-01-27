class CoachController < ApplicationController
  before_action :current_coach

  def edit
    @problems = Problem.all
  end

  def update
    if current_coach.update(updated_params)
      params[:coach][:problems]&.each do |problem|
        current_coach.problems << Problem.find_by(title: problem)
      end
      redirect_to dashboard_coach_page_path(current_coach.id)
    else
      render :edit
    end
  end

  def password_update
  end

  def password_coach_update
    if BCrypt::Password.new(current_coach.password_digest) == params[:coach][:old_password]
      if current_coach.update(password_updated_params)
        redirect_to dashboard_coach_page_path(current_coach.id)
      else
        render :password_update
      end
    else
      render :password_update
    end
  end

  private

  def updated_params
    params.require(:coach).permit(:name, :email, :coach_avatar, :about, :age, :gender, :experience, :licenses, :socials,
                                  :education)
  end

  def password_updated_params
    params.require(:coach).permit(:password, :password_confirmation)
  end
end
