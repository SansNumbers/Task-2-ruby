class ApplicationController < ActionController::Base
  add_flash_types :warning, :info, :error, :success

  def check_user!
    redirect_to sign_in_user_path unless session[:user_id]
  end

  def check_coach!
    redirect_to sign_in_coach_path unless session[:coach_id]
  end
end
