Rails.application.routes.draw do
  root 'landing_page#index'

  ###############################################################
  # SIGN UP
  # user
  get '/sign_up_user', to: 'sign_up_user#index'
  post '/sign_up_user', to: 'sign_up_user#create'
  get '/sign_up_user/verification', to: 'sign_up_user#edit'
  patch '/sign_up_user/verification', to: 'sign_up_user#update'
  get '/sign_up_user/verification/resend/', to: 'sign_up_user#resend', as: 'resend_user'

  # coach
  get '/sign_up_coach', to: 'sign_up_coach#index'
  post '/sign_up_coach', to: 'sign_up_coach#create'
  get '/sign_up_coach/verification', to: 'sign_up_coach#edit'
  patch '/sign_up_coach/verification', to: 'sign_up_coach#update'
  get '/sign_up_coach/verification/resend/', to: 'sign_up_coach#resend', as: 'resend_coach'

  ###############################################################
  # SIGN IN
  # user
  get 'sign_in_user', to: 'sign_in_user#index'
  post '/sign_in_user', to: 'sign_in_user#create'
  get '/sign_in_user', to: 'sign_in_user#new'
  delete 'logout', to: 'sign_in_user#logout', as: 'logout_user'

  # coach
  get '/sign_in_coach', to: 'sign_in_coach#index'
  post '/sign_in_coach', to: 'sign_in_coach#create'
  delete 'logout', to: 'sign_in_coach#logout', as: 'logout_coach'

  ###############################################################
  # CONTROLLERS
  # user
  get '/user/:id', to: 'user#dashboard', as: 'user_page'
  get '/user/:id/update', to: 'user#edit', as: 'update_user_profile'
  patch '/user/:id/update', to: 'user#update'
  get '/user/:id/password_edit', to: 'user#password_update', as: 'password_change_user'
  patch '/user/:id/password_edit', to: 'user#password_user_update'

  get '/user/:id/dashboard', to: 'user#dashboard', as: 'user_dashboard_page'
  get '/user/:id/techniques', to: 'user#techniques', as: 'user_techniques_page'
  get '/user/:id/coaches', to: 'user#coaches_page', as: 'user_coahes_page'

  get '/user/:id/coaches/invitation/:coach_id', to: 'user#new', as: 'invitation'
  post 'user/:id/coaches/invitation/:coach_id', to: 'user#send_invintation'
  delete 'cancel/:invite_id', to: 'user#cancel_invite', as: 'cancel_coach_invite'
  delete 'end/:invite_id', to: 'user#end_cooperation', as: 'end_cooperation_coach_invite'

  # get '/user/:id/dashboard/:technique_id/step/:step_id', to: 'user#user_technique_detail', as: 'user_technique_detail'
  # patch '/user/:id/dashboard/:technique_id/step/:step_id', to: 'user#restart', as: 'restart'
  # get '/user/:id/dashboard/:technique_id/step/:step_id/rate', to: 'user#finish', as: 'user_rate_window'

  # post '/user/:id/dashboard/:technique_id/step/:step_id/rate', to: 'user#like', as: 'like_rating'
  # patch '/user/:id/dashboard/:technique_id/step/:step_id/rate', to: 'user#dislike', as: 'dislike_rating'

  # coach
  get '/coach/:id', to: 'coach#show', as: 'coach_page'
  get '/coach/:id/update', to: 'coach#edit', as: 'update_coach_profile'
  patch '/coach/:id/update', to: 'coach#update'
  get '/coach/:id/password_edit', to: 'coach#password_update', as: 'password_change_coach'
  patch '/coach/:id/password_edit', to: 'coach#password_coach_update'

  ###############################################################
  # RESET PASSWORD
  # user
  get '/reset_password', to: 'reset_password_user#index'
  post '/reset_password', to: 'reset_password_user#create'
  get '/reset_password/edit', to: 'reset_password_user#edit'
  patch '/reset_password/edit', to: 'reset_password_user#update'

  # coach
  get '/reset_password_coach', to: 'reset_password_coach#new'
  post '/reset_password_coach', to: 'reset_password_coach#create'
  get '/reset_password_coach/edit', to: 'reset_password_coach#edit'
  patch '/reset_password_coach/edit', to: 'reset_password_coach#update'

  ###############################################################
end
