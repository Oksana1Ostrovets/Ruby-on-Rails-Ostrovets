class Genre
    attr_accessor :name
  
    def initialize(name)
      @name = name
    end
  
    def to_s
      @name
    end
  
    def to_h
      { "name" => @name }
    end
  end
  