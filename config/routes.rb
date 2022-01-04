Rails.application.routes.draw do
  root 'landing_page#index'

  # sign-up
  get '/sign_up_user', to: 'sign_up_user#index'
  post '/sign_up_user', to: 'sign_up_user#create'
  get '/sign_up_user/verification', to: 'sign_up_user#edit'
  patch '/sign_up_user/verification', to: 'sign_up_user#update'
  get '/sign_up_user/verification/resend/', to: 'sign_up_user#resend', as: 'resend'

  # sign-in
  get 'sign_in_user', to: 'sign_in_user#index'
  post '/sign_in_user', to: 'sign_in_user#create'
  get '/sign_in_user', to: 'sign_in_user#new'
  delete 'logout', to: 'sign_in_user#destroy'

  # user contoller
  get '/user/:id', to: 'user#show', as: 'user_page'
end
