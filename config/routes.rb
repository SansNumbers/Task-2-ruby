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
  get '/user/:id', to: 'user#show', as: 'user_page'

  get '/user/:id/update', to: 'user#edit', as: 'update_user_profile'
  patch '/user/:id/update', to: 'user#update'
  get '/user/:id/password_edit', to: 'user#password_update', as: 'password_change_user'
  patch '/user/:id/password_edit', to: 'user#password_user_update'

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
