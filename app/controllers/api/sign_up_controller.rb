class SignUpController < ActionController::API
    
    def user_sign_up
        @user = User.new(permited_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def coach_sign_up
        @coach = Coach.new(permited_params)
        if @coach.save
            render json: @coach, status: :created
        else
            render json: { errors: @coach.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def permited_params
        params.permit(:name, :email, :password, :password_confirmation, :age, :gender, :about)
    end

end