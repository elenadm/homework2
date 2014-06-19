class MoviesController < ApplicationController
  before_action :clearance_authorize
  helper_method :ratings_params, :all_ratings, :allow, :current_user, :author

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
    authorize @movie
  end

  def create
    @movie = Movie.new movie_params
    @movie.user = current_user
    #authorize @movie

    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_url
    else
      render 'new'
    end
  end

  def edit
    @movie = find_movie
    authorize @movie
  end

  def update
    @movie = find_movie
    authorize @movie
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
  def allow
    Pundit.policy!(current_user, @movie)
  end

  def find_movie
    Movie.find(params[:id])
  end

  def movie_params
    params[:movie].permit(:title, :rating, :release_date, :description, :avatar)
  end

  def author(movie)
    movie.user.id == current_user.id ? 'you' : movie.user.email
  end
end

