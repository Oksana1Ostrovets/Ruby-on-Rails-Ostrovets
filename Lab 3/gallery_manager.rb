require 'json'
require 'yaml'

class Painting
  attr_accessor :title, :author, :genre, :year, :price

  def initialize(title, author, genre, year, price)
    @title = title
    @author = author
    @genre = genre
    @year = year
    @price = price
  end

  def to_s
    "#{@title} - #{@author} (#{@year}), Жанр: #{@genre}, Ціна: #{@price} доларів"
  end
end

class GalleryManager
  attr_accessor :paintings

  def initialize
    @paintings = []
  end

  def add_painting(painting)
    @paintings << painting
  end

  def edit_painting(old_title, new_title, new_author, new_genre, new_year, new_price)
    painting = find_painting(old_title)
    if painting
      painting.title = new_title
      painting.author = new_author
      painting.genre = new_genre
      painting.year = new_year
      painting.price = new_price
    end
  end

  def delete_painting(title)
    @paintings.reject! { |painting| painting.title == title }
  end

  def search_painting(title)
    @paintings.select { |painting| painting.title.include?(title) }
  end

  def view_all_paintings
    @paintings.each { |painting| puts painting }
  end

  def load_from_json(file_name)
    if File.exist?(file_name)
      data = JSON.parse(File.read(file_name))
      @paintings = data.map do |title, painting_data|
        Painting.new(title, painting_data["author"], painting_data["genre"], painting_data["year"], painting_data["price"])
      end
    end
  end

  def save_to_json(file_name)
    data = @paintings.map do |painting|
      {
        painting.title => {
          "author" => painting.author,
          "genre" => painting.genre,
          "year" => painting.year,
          "price" => painting.price
        }
      }
    end
    File.open(file_name, "w") { |f| f.write(JSON.pretty_generate(data)) }
  end

  def load_from_yaml(file_name)
    if File.exist?(file_name)
      data = YAML.load(File.read(file_name))
      @paintings = data.map do |title, painting_data|
        Painting.new(title, painting_data["author"], painting_data["genre"], painting_data["year"], painting_data["price"])
      end
    end
  end

  def save_to_yaml(file_name)
    data = @paintings.map do |painting|
      {
        painting.title => {
          "author" => painting.author,
          "genre" => painting.genre,
          "year" => painting.year,
          "price" => painting.price
        }
      }
    end
    File.open(file_name, "w") { |f| f.write(data.to_yaml) }
  end
end
