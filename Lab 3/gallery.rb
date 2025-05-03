require_relative 'gallery_manager'

manager = GalleryManager.new

def prompt(label)
  print "#{label}: "
  gets.chomp
end

loop do
  puts "\n🎨 Картинна Галерея — Меню"
  puts "1. Додати картину"
  puts "2. Редагувати картину"
  puts "3. Видалити картину"
  puts "4. Пошук картини"
  puts "5. Перегляд усіх картин"
  puts "6. Зберегти у JSON"
  puts "7. Завантажити з JSON"
  puts "8. Зберегти у YAML"
  puts "9. Завантажити з YAML"
  puts "0. Вийти"
  print "\n👉 Оберіть опцію: "
  choice = gets.chomp

  case choice
  when "1"
    title = prompt("Назва картини")
    author = prompt("Автор")
    genre = prompt("Жанр")
    year = prompt("Рік").to_i
    price = prompt("Ціна").to_f
    painting = Painting.new(title, author, genre, year, price)
    manager.add_painting(painting)
    puts "✅ Картину '#{title}' додано."

  when "2"
    title = prompt("Назва картини для редагування")
    if manager.find_painting(title)
      author = prompt("Новий автор")
      genre = prompt("Новий жанр")
      year = prompt("Новий рік").to_i
      price = prompt("Нова ціна").to_f
      manager.edit_painting(title, {
        "author" => author,
        "genre" => genre,
        "year" => year,
        "price" => price
      })
      puts "✏️ Картину оновлено."
    else
      puts "❌ Картину не знайдено."
    end

  when "3"
    title = prompt("Назва картини для видалення")
    if manager.delete_painting(title)
      puts "🗑️ Картину видалено."
    else
      puts "❌ Картину не знайдено."
    end

  when "4"
    title = prompt("Назва картини для пошуку")
    painting = manager.find_painting(title)
    if painting
      puts "✅ Знайдено:"
      puts painting.to_s
    else
      puts "❌ Картину не знайдено."
    end

  when "5"
    if manager.paintings.empty?
      puts "📭 Колекція порожня."
    else
      puts "🖼️ Всього картин: #{manager.paintings.size}"
      manager.view_all_paintings        
    end

  when "6"
    manager.save_to_json("paintings.json")
    puts "💾 Збережено у paintings.json"

  when "7"
    manager.load_from_json("paintings.json")
    puts "📥 Завантажено з paintings.json"

  when "8"
    manager.save_to_yaml("paintings.yaml")
    puts "💾 Збережено у paintings.yaml"

  when "9"
    manager.load_from_yaml("paintings.yaml")
    puts "📥 Завантажено з paintings.yaml"

  when "0"
    puts "👋 До побачення!"
    break

  else
    puts "❗ Невірна опція!"
  end
end
