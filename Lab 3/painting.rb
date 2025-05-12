require_relative 'author'
require_relative 'genre'

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
    "#{@title} - #{author}, Жанр: #{genre}, Рік: #{@year}, Ціна: #{@price}"
  end

  def to_h
    {
      title: @title,
      author: { name: @author.name, country: @author.country },
      genre: { name: @genre.name },
      year: @year,
      price: @price
    }
  end  
  

  def self.from_h(hash)
    author = Author.new(hash["author"]["name"], hash["author"]["country"])
    genre = Genre.new(hash["genre"]["name"])
    new(hash["title"], author, genre, hash["year"], hash["price"])
  end
end
