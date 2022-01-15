module Coaches
  class SignUp < ApplicationService
    include BCrypt

    def initialize(params)
      @params = params
      @coach = Coach.new(@params)
    end

    def call
      save_coach
    end

    private

    def save_coach
      @coach.save
      raise ServiceError, @coach.errors.full_messages if @coach.invalid?

      @coach
    end
  end
end
