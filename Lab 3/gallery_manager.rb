require 'json'
require 'yaml'
require_relative 'painting'

class GalleryManager
  attr_accessor :paintings

  def initialize
    @paintings = []
  end

  def add_painting(painting)
    @paintings << painting
  end

  def edit_painting(old_title, new_painting)
    index = @paintings.find_index { |p| p.title == old_title }
    @paintings[index] = new_painting if index
  end

  def delete_painting(title)
    before = @paintings.size
    @paintings.reject! { |p| p.title == title }
    before != @paintings.size
  end

  def find_painting(title)
    @paintings.find { |p| p.title == title }
  end

  def view_all_paintings
    @paintings.each { |p| puts p }
  end

  def save_to_json
    file = 'paintings.json'
    data = @paintings.map(&:to_h)
    File.write(file, JSON.pretty_generate(data))
    puts "💾 Збережено у #{file}."
  end

  def load_from_json
    file = 'paintings.json'
    begin
      data = JSON.parse(File.read(file))
      @paintings = data.map do |item|
        author = Author.new(item["author"]["name"], item["author"]["country"])
        genre = Genre.new(item["genre"]["name"])
        Painting.new(item["title"], author, genre, item["year"], item["price"])
      end
      puts "📂 Дані завантажено з #{file}."
    rescue Errno::ENOENT
      puts "⚠️ Файл не знайдено!"
    rescue JSON::ParserError
      puts "⚠️ Помилка при обробці файлу JSON!"
    end
  end

  def save_to_yaml
    file = 'paintings.yaml'
    data = @paintings.map(&:to_h)
    File.write(file, YAML.dump(data))
    puts "💾 Збережено у #{file}."
  end

  def load_from_yaml
    file = 'paintings.yaml'
    begin
      data = YAML.load(File.read(file))
      @paintings = data.map do |item|
        author = Author.new(item["author"]["name"], item["author"]["country"])
        genre = Genre.new(item["genre"]["name"])
        Painting.new(item["title"], author, genre, item["year"], item["price"])
      end
      puts "📂 Дані завантажено з #{file}."
    rescue Errno::ENOENT
      puts "⚠️ Файл не знайдено!"
    rescue Psych::SyntaxError
      puts "⚠️ Помилка при обробці файлу YAML!"
    end
  end
end

