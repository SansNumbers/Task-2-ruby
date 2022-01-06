class CoachController < ApplicationController
    def show
        @coach = Coach.find_by_id(session[:coach_id])
    end
end
