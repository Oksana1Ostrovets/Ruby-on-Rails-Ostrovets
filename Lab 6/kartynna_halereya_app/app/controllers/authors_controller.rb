class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @sort_column = params[:sort] || "name"
    @sort_order = params[:order] == "asc" ? "desc" : "asc"

    @authors = Author.all.order("#{@sort_column} #{@sort_order}")

    if params[:country].present?
      @authors = @authors.where(country: params[:country])
    end
  end

  def show; end

  def new
    @author = Author.new
  end

  def create
    author_params[:name] = author_params[:name].strip
    @author = Author.new(author_params)
    if @author.save
      redirect_to @author, notice: "Автор успішно створений."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @author.update(author_params)
      redirect_to @author, notice: "Автор оновлений."
    else
      render :edit
    end
  end

  def destroy
    if @author.paintings.exists?
      redirect_to authors_path, alert: "Цей автор має картини, що пов'язані з ним."
    else
      @author.destroy
      redirect_to authors_path, notice: "Автор видалений."
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :birth_year, :country)
  end
end
