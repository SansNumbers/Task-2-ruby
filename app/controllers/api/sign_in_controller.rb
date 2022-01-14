module Api
  class SignInController < ::ApiController
    before_action :authorize_request

    def user_sign_in
      @user = User.find_by(email: params[:email])

      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        render json: { token: token, user: @user }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end

    def coach_sign_in
      @coach = Coach.find_by_email(params[:email])

      if @coach&.authenticate(params[:password])

        token = JsonWebToken.encode(coach_id: @coach.id)
        render json: { token: token, coach: @coach }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  end
end
