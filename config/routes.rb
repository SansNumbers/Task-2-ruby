Rails.application.routes.draw do
  root 'landing_page#index'

  # sign-up # user
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

  # sign-in # user
  get 'sign_in_user', to: 'sign_in_user#index'
  post '/sign_in_user', to: 'sign_in_user#create'
  get '/sign_in_user', to: 'sign_in_user#new'
  # delete 'logout', to: 'sign_in_user#destroy'

  # coach
  get '/sign_in/coach', to: 'sign_in_coach#new'
  post '/sign_in/coach', to: 'sign_in_coach#create'
  # delete 'logout', to: 'authorization_coach#destroy', as: 'logout_coach'

  # user contoller
  get '/user/:id', to: 'user#show', as: 'user_page'
  # get '/coach/:id', to: 'coach#show', as: 'coach_page'

  # # reset password contoller
  get '/reset_password/index', to: 'reset_password_user#index'
  post '/reset_password/index', to: 'reset_password_user#create'
  get '/reset_password/edit', to: 'reset_password_user#edit'
  patch '/reset_password/edit', to: 'reset_password_user#update'

  # # reset password coach controller
  # get '/reset_password_coach/new', to: "reset_password_coach#new"
  # post '/reset_password_coach/new', to: "reset_password_coach#create"
  # get '/reset_password_coach/edit', to: "reset_password_coach#edit"
  # patch '/reset_password_coach/edit', to: "reset_password_coach#update"
end
