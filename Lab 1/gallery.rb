require_relative 'gallery_manager'

manager = GalleryManager.new

loop do
  puts "\n📌 Меню:"
  puts "1. Додати картину"
  puts "2. Редагувати картину"
  puts "3. Видалити картину"
  puts "4. Пошук картини"
  puts "5. Показати всі картини"
  puts "6. Зберегти у JSON"
  puts "7. Завантажити з JSON"
  puts "8. Зберегти у YAML"
  puts "9. Завантажити з YAML"
  puts "0. Вийти"
  print "👉 Оберіть опцію: "
  choice = gets.chomp

  case choice
  when "1"
    print "Назва картини: "
    title = gets.chomp
    print "Автор: "
    author = gets.chomp
    print "Жанр: "
    genre = gets.chomp
    print "Рік: "
    year = gets.chomp.to_i
    print "Ціна: "
    price = gets.chomp.to_f
    manager.add_painting(title, {
      "author" => author,
      "genre" => genre,
      "year" => year,
      "price" => price
    })
    puts "✅ Картину додано."

  when "2"
    print "Назва картини для редагування: "
    title = gets.chomp
    if manager.find_painting(title)
      print "Новий автор: "
      author = gets.chomp
      print "Новий жанр: "
      genre = gets.chomp
      print "Новий рік: "
      year = gets.chomp.to_i
      print "Нова ціна: "
      price = gets.chomp.to_f
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
    print "Назва картини для видалення: "
    title = gets.chomp
    manager.delete_painting(title)
    puts "🗑️ Картину видалено."

  when "4"
    print "Назва картини для пошуку: "
    title = gets.chomp
    painting = manager.find_painting(title)
    if painting
      puts "✅ Знайдено:"
      painting.each { |k, v| puts "#{k.capitalize}: #{v}" }
    else
      puts "❌ Картину не знайдено."
    end

  when "5"
    manager.list_paintings

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
