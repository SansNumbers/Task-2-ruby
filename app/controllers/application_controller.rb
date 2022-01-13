class ApplicationController < ActionController::Base
  add_flash_types :warning, :info, :error, :success

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def current_coach
    return unless session[:coach_id]

    @current_coach ||= Coach.find(session[:coach_id])
  end

end
