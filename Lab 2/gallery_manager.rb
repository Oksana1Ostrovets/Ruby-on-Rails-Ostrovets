require 'json'
require 'yaml'

class GalleryManager
  attr_reader :paintings

  def initialize
    @paintings = {}
  end

  def add_painting(title, details)
    @paintings[title] = details
  end

  def edit_painting(title, new_details)
    @paintings[title] = new_details if @paintings.key?(title)
  end

  def delete_painting(title)
    @paintings.delete(title)
  end

  def find_painting(title)
    @paintings[title]
  end

  def list_paintings
    @paintings.each do |title, info|
      puts "Назва: #{title}"
      info.each { |k, v| puts "  #{k.capitalize}: #{v}" }
      puts "-" * 20
    end
  end

  def save_to_json(file)
    File.write(file, JSON.pretty_generate(@paintings))
  end

  def load_from_json(file)
    @paintings = JSON.parse(File.read(file))
  end

  def save_to_yaml(file)
    File.write(file, @paintings.to_yaml)
  end

  def load_from_yaml(file)
    @paintings = YAML.load_file(file)
  end
end
