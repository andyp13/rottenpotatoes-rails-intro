class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.acceptable_ratings
    
    if(params[:ratings] != nil )
       @sorting = session[:sort_by]
       @sorting_col = session[:sort_by]
       session[:ratings] = params[:ratings]
      @movies = Movie.order(@sorting).where(rating: params[:ratings].keys)
    else
      
      @sorting_col = params[:sort_by]
      session[:sort_by] = params[:sort_by]
      @sorting = params[:sort_by]
      if(session[:ratings] != nil)
        @movies = Movie.order(@sorting).where(rating: session[:ratings].keys)
        redirect_to movies_path(:sort_by=>session[:sort_by], :ratings=>session[:ratings])
      else
        @movies = Movie.order(@sorting).all
      end
      
    end
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
