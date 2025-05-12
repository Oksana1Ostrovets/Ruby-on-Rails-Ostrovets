class PaintingsController < ApplicationController
  before_action :set_painting, only: [:show, :edit, :update, :destroy]

  def index
    @sort_column = params[:sort] || "title"
    @sort_order = params[:order] == "asc" ? "desc" : "asc"

    @paintings = Painting.includes(:author, :genre)
                         .order("#{@sort_column} #{@sort_order}")

    if params[:search].present?
      @paintings = @paintings.where("title LIKE ?", "%#{params[:search]}%")
    end

    @paintings = @paintings.page(params[:page]).per(6)
  end

  def catalog
    @q = Painting.ransack(params[:q])
    @paintings = @q.result.includes(:author, :genre).page(params[:page]).per(6)
  end

  def show; end

  def new
    @painting = Painting.new
  end

  def create
    @painting = Painting.new(painting_params)
    if @painting.save
      redirect_to @painting, notice: "Картина успішно створена."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @painting.update(painting_params)
      redirect_to @painting, notice: "Картина оновлена."
    else
      render :edit
    end
  end

  def destroy
    @painting.destroy
    redirect_to paintings_path, notice: "Картина видалена."
  end

  private

  def set_painting
    @painting = Painting.find(params[:id])
  end

  def painting_params
    params.require(:painting).permit(:title, :year, :price, :author_id, :genre_id)
  end
end
