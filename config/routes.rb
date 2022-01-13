Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'landing_page#index'

  namespace :api do
    post '/user/sign_in', to: 'auth#user_login'
    post '/coach/sign_in', to: 'auth#coach_login'

    post '/user/sign_up', to: 'registration#user_registration'
    post '/coach/sign_up', to: 'registration#coach_registration'

    get '/coach/users', to: 'coach#users'
    get '/user/techniques', to: 'user#get_techniques'
    get '/user/techniques/:technique_id/steps', to: 'user#steps'
  end

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

  ###############################################################
  # user update profile

  get '/user/:id', to: 'user#dashboard', as: 'dashboard_user_page'
  get '/user/:id/update', to: 'user#edit', as: 'update_user_profile'
  patch '/user/:id/update', to: 'user#update'
  get '/user/:id/password_edit', to: 'user#password_update', as: 'password_change_user'
  patch '/user/:id/password_edit', to: 'user#password_user_update'

  # user navbar items
  get '/user/:id/dashboard', to: 'user#dashboard', as: 'user_dashboard_page'
  get '/user/:id/techniques', to: 'user#techniques', as: 'user_techniques_page'
  get '/user/:id/coaches', to: 'user#coaches', as: 'user_coaches_page'

  # user dashboard items
  patch '/user/:id/dashboard/:technique_id/step/:step_id', to: 'user#restart', as: 'technique_restart_user'
  get '/user/:id/dashboard/:technique_id/step/:step_id/rate', to: 'user#rate', as: 'technique_rate_user'

  post '/user/:id/dashboard/:technique_id/step/:step_id/rate', to: 'user#like', as: 'like_rating'
  patch '/user/:id/dashboard/:technique_id/step/:step_id/rate', to: 'user#dislike', as: 'dislike_rating'

  # user coaches items
  get '/user/:id/coaches/invitation/:coach_id', to: 'user#coach_info', as: 'invitation'
  post 'user/:id/coaches/invitation/:coach_id', to: 'user#send_invitation'

  delete 'cancel/:invite_id', to: 'user#cancel_invite', as: 'cancel_coach_invite'

  get '/user/dashboard/end', to: 'user#modal_end_cooperation', as: 'end_cooperation'
  delete 'end/:invite_id', to: 'user#end_cooperation', as: 'end_cooperation_confirm'

  # user technique items
  get '/user/:id/dashboard/:technique_id/step/:step_id', to: 'user#technique_detail_user', as: 'technique_detail_user'

  ###############################################################
  # coach

  ###############################################################

  # coach update profile
  get '/coach/:id/update', to: 'coach#edit', as: 'update_coach_profile'
  patch '/coach/:id/update', to: 'coach#update'
  get '/coach/:id/password_edit', to: 'coach#password_update', as: 'password_change_coach'
  patch '/coach/:id/password_edit', to: 'coach#password_coach_update'

  # coach navbar items
  get '/coach/:id', to: 'coach#dashboard', as: 'dashboard_coach_page'
  get '/coach/:id/dashboard', to: 'coach#dashboard', as: 'coach_dashboard_page'
  get '/coach/:id/my_users', to: 'coach#coach_users', as: 'coach_users_page'
  get '/coach/:id/library', to: 'coach#library', as: 'coach_library_page'

  # coach technique items
  get '/coach/:id/library/:technique_id', to: 'coach#technique_detail', as: 'technique_detail_coach'

  # coach library items
  get '/coach/:id/library/:technique_id/recommendation', to: 'coach#new', as: 'recommend_to_users_page'
  post '/coach/:id/library/:technique_id/recommendation', to: 'coach#create'

  # coach users items
  get '/coach/:id/user/:user_id/detail', to: 'coach#user_detail', as: 'user_detail'

  patch 'confirm/:invite_id', to: 'coach#confirm', as: 'confirm_user_invite'
  delete 'refuse/:invite_id', to: 'coach#refuse', as: 'refuse_user_invite'

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
