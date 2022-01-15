module Users
  class SignUp < ApplicationService
    include BCrypt

    def initialize(params)
      @params = params
      @user = User.new(@params)
    end

    def call
      save_user
    end

    private

    def save_user
      @user.save
      raise ServiceError, @user.errors.full_messages if @user.invalid?

      @user
    end
  end
end
