class Painting
    attr_accessor :title, :author, :genre, :year, :price
  
    def initialize(title, author, genre, year, price)
      @title = title
      @author = author
      @genre = genre
      @year = year
      @price = price
    end
  
    def to_h
      {
        "title" => @title,
        "author" => @author,
        "genre" => @genre,
        "year" => @year,
        "price" => @price
      }
    end
  
    def to_s
      "Назва: #{@title}, Автор: #{@author}, Жанр: #{@genre}, Рік: #{@year}, Ціна: #{@price}"
    end
  end
  