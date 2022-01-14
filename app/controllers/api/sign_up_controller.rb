module Api
  class SignUpController < ::ApiController
    skip_before_action :verify_authenticity_token

    def user_sign_up
      @user = User.new(permited_params)
      if @user.save
        render json: @user, status: :ok
      else
        render json: { errors: @user.errors.full_messages }
      end
    end

    private

    def permited_params
      params.permit(:name, :email, :password, :password_confirmation, :age, :gender, :about)
    end
  end
end
