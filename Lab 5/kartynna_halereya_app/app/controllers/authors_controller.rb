class AuthorsController < ApplicationController
    before_action :set_author, only: [:show, :edit, :update, :destroy]
  
    def index
      @authors = Author.all
    end
  
    def show; end
  
    def new
      @author = Author.new
    end
  
    def create
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
      @author.destroy
      redirect_to authors_path, notice: "Автор видалений."
    end
  
    private
  
    def set_author
      @author = Author.find(params[:id])
    end
  
    def author_params
      params.require(:author).permit(:name, :birth_year, :country)
    end
  end
  