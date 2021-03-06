class MoviesController < ApplicationController
  before_filter :authorize
  helper_method :ratings_params, :all_ratings

  def index
    session[:ratings] = params[:ratings] if params[:ratings]
    session[:mov] = params[:mov]
    @movies = Movie.list(rating: ratings_params.keys, order: ("#{params[:mov]}" + " " + "#{params[:direction]}"))
  end

  def show
    @movie = find_movie
  end

  def all_ratings
    @all_ratings ||= Movie.all_ratings
  end

  def ratings_params
    session[:ratings] || Hash[all_ratings.map { |x| [x, "1"] }]
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
  end

  def update
    @movie = find_movie
    if @movie.update_attributes(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def destroy
    @movie = find_movie
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_url
  end


  private
  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    params[:movie].permit(:title, :rating, :release_date, :description, :avatar)
  end


end

