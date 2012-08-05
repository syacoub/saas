class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if ( (!params[:sort_by] && !session[sort_by]) || (!params[:ratings] && !session[:ratings]) )
      sort_by = params[:sort_by] ? session[:sort_by] = params[:sort_by] : session[:sort_by]
      ratings = params[:ratings] ? session[:ratings] = params[:ratings] : session[:ratings]
      flash.keep
      redirect_to movies_url(:sort_by => sort_by, :ratings => ratings)
    end
    
    @included_ratings = params[:ratings] ? params[:ratings].keys : nil
    @sort_by = params[:sort_by]
    @all_ratings = Movie.all_ratings
    @movies = @included_ratings ? Movie.where(["rating IN (?)", @included_ratings]).find(:all, :order => @sort_by ? @sort_by : nil) : []
    @included_ratings_hash = params[:ratings] ? params[:ratings] : nil
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
