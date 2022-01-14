Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'landing_page#index'

  namespace :api do
    post '/user_sign_up', to: 'sign_up#user_sign_up'
    post '/user_sign_in', to: 'sign_in#user_sign_in'
    get '/index', to: 'user#index'
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

  scope '/user' do
    # user update profile
    get 'update', to: 'user#edit', as: 'update_user_profile'
    patch 'update', to: 'user#update'
    get 'password_edit', to: 'user#password_update', as: 'password_change_user'
    patch 'password_edit', to: 'user#password_user_update'

    # user navbar items
    get 'dashboard', to: 'dashboard#dashboard', as: 'user_dashboard_page'
    get 'techniques', to: 'technique#techniques', as: 'user_techniques_page'
    get 'coaches', to: 'dashboard#coaches', as: 'user_coaches_page'

    scope '/dashboard' do
      # user dashboard items
      patch ':technique_id/step/:step_id', to: 'technique#restart', as: 'technique_restart_user'
      get ':technique_id/step/:step_id/rate', to: 'technique#rate', as: 'technique_rate_user'

      post ':technique_id/step/:step_id/rate', to: 'technique#like', as: 'like_rating'
      patch ':technique_id/step/:step_id/rate', to: 'technique#dislike', as: 'dislike_rating'

      get ':technique_id/step/:step_id', to: 'dashboard#technique_detail_user',
                                         as: 'technique_detail_user'

      get 'end', to: 'invitation#modal_end_cooperation', as: 'end_cooperation'
    end

    scope '/coaches' do
      get 'invitation/:coach_id', to: 'invitation#coach_info', as: 'invitation'
      post 'invitation/:coach_id', to: 'invitation#send_invitation'
    end

    delete 'cancel/:invite_id', to: 'invitation#cancel_invite', as: 'cancel_coach_invite'

    delete 'end/:invite_id', to: 'invitation#end_cooperation', as: 'end_cooperation_confirm'
  end

  ###############################################################
  # coach

  ###############################################################
  scope '/coach' do
    # coach update profile
    get 'update', to: 'coach#edit', as: 'update_coach_profile'
    patch 'update', to: 'coach#update'
    get 'password_edit', to: 'coach#password_update', as: 'password_change_coach'
    patch 'password_edit', to: 'coach#password_coach_update'

    # coach navbar items
    get 'dashboard', to: 'coach_invitation#dashboard', as: 'dashboard_coach_page'
    get 'my_users', to: 'coach_invitation#coach_users', as: 'coach_users_page'
    get 'library', to: 'library#library', as: 'coach_library_page'

    scope '/library' do
      # coach technique items
      get ':technique_id', to: 'library#technique_detail', as: 'technique_detail_coach'

      # coach library items
      get ':technique_id/recommendation', to: 'library#new', as: 'recommend_to_users_page'
      post ':technique_id/recommendation', to: 'library#create'
    end
    # coach users items
    get 'user/:user_id/detail', to: 'coach_invitation#user_detail', as: 'user_detail'

    patch 'confirm/:invite_id', to: 'coach_invitation#confirm', as: 'confirm_user_invite'
    delete 'refuse/:invite_id', to: 'coach_invitation#refuse', as: 'refuse_user_invite'
  end

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
