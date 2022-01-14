module Api
  class UserController < ::ApiController
    before_action :authorize_user_request

    def index
      @coaches = Coach.all
      if @coaches.present?
        render json: { user: @current_user, coaches: @coaches }, status: :ok
      else
        render json: { user: @current_user, coaches: 'There are no coaches yet.' }, status: :ok
      end
    end
  end
end
