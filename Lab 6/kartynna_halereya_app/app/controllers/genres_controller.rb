class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  def index
    @sort_column = params[:sort] || "name"
    @genres = Genre.order(@sort_column)
                   .page(params[:page])
                   .per(6)
  end

  def show; end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: "Жанр успішно створений."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: "Жанр оновлений."
    else
      render :edit
    end
  end

  def destroy
    if @genre.paintings.exists?
      flash[:alert] = "Цей жанр мав картину, і вона також видалена разом з жанром."
    end
    
    @genre.destroy
    redirect_to genres_path, notice: "Жанр видалений."
  end
  
  
  

  def destroy_empty_genres
    genres_without_paintings = Genre.left_joins(:paintings).where(paintings: { id: nil })
    
    if genres_without_paintings.any?
      genres_without_paintings.destroy_all
      redirect_to genres_path, notice: "Жанри без картин успішно видалено."
    else
      redirect_to genres_path, alert: "Немає жанрів без картин для видалення."
    end
  end
  

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :description)
  end
end
