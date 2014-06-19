class WelcomeController < ApplicationController
  def show
    @sample_movie = Movie.where(published: true).order("RANDOM()").first
  end
end
