require_relative 'gallery_manager'
require_relative 'author'
require_relative 'genre'
require_relative 'painting'

manager = GalleryManager.new

def create_painting
  print "Назва картини: "
  title = gets.chomp

  print "Ім'я автора: "
  author_name = gets.chomp
  print "Країна автора: "
  author_country = gets.chomp
  author = Author.new(author_name, author_country)

  print "Жанр: "
  genre_name = gets.chomp
  genre = Genre.new(genre_name)

  print "Рік створення: "
  year = gets.chomp.to_i
  print "Ціна: "
  price = gets.chomp.to_f

  Painting.new(title, author, genre, year, price)
end

loop do
  puts "\n--- Галерея ---"
  puts "1. Додати картину"
  puts "2. Редагувати картину"
  puts "3. Видалити картину"
  puts "4. Переглянути всі картини"
  puts "5. Зберегти у JSON"
  puts "6. Завантажити з JSON"
  puts "7. Зберегти у YAML"
  puts "8. Завантажити з YAML"
  puts "0. Вийти"
  print "Оберіть дію: "
  choice = gets.chomp.to_i

  case choice
  when 1
    painting = create_painting
    manager.add_painting(painting)
    puts "✅ Картину додано."

  when 2
    print "Введіть назву картини для редагування: "
    old_title = gets.chomp
    if manager.find_painting(old_title)
      puts "Введіть нові дані:"
      new_painting = create_painting
      manager.edit_painting(old_title, new_painting)
      puts "✅ Картину оновлено."
    else
      puts "❌ Картину не знайдено."
    end

  when 3
    print "Введіть назву картини для видалення: "
    title = gets.chomp
    if manager.delete_painting(title)
      puts "🗑️ Картину видалено."
    else
      puts "❌ Картину не знайдено."
    end

  when 4
    puts "\n🖼️ Всі картини:"
    manager.view_all_paintings

  when 5
    manager.save_to_json

  when 6
    manager.load_from_json

  when 7
    manager.save_to_yaml

  when 8
    manager.load_from_yaml

  when 0
    puts "👋 До побачення!"
    break

  else
    puts "❌ Невірний вибір. Спробуйте ще раз."
  end
end
