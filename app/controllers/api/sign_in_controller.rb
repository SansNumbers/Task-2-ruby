module Api
  class SignInController < ::ApiController
    skip_before_action :verify_authenticity_token

    def user_sign_in
      @user = User.find_by(email: params[:email])

      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        
        render json: { token: token, user: @user }, status: :ok
      else
        render json: { error: 'unauthorized' }
      end
    end

    def permited_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
