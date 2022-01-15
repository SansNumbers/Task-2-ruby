module Users
  class SignIn < ApplicationService
    include BCrypt

    def initialize(params)
      @params = params
    end

    def call
      unique_email
      hash_password
      @user
    end

    private

    def unique_email
      @user = User.find_by(email: @params[:email])
      raise ServiceError, 'Email or password are invalid' if @user.nil?
    end

    def hash_password
      raise ServiceError, 'Email or password are invalid' if @user.authenticate(@params[:password]) == false
    end
  end
end
