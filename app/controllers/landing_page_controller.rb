class LandingPageController < ApplicationController
  def index
    @problems = Problem.all
    @techniques = Technique.all
    @coaches = Coach.all
  end
end
