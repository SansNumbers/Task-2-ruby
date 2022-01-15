module Coaches
  class SignIn < ApplicationService
    include BCrypt

    def initialize(params)
      @params = params
    end

    def call
      unique_email
      hash_password
      @coach
    end

    private

    def unique_email
      @coach = Coach.find_by(email: @params[:email])
      raise ServiceError, 'Email or password are invalid' if @coach.nil?
    end

    def hash_password
      raise ServiceError, 'Email or password are invalid' if @coach.authenticate(@params[:password]) == false
    end
  end
end
