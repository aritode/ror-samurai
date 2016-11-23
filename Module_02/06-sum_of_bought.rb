# 'Install terminal-table gem:'
# '$ gem install terminal-table'

require 'terminal-table'

puts 'Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). '
puts 'Введите "стоп" в качестве названия товара для остановки'
puts

products = {}

loop do
  print 'Введите название товара: '
  title = STDIN.gets.chomp
  break if title == "стоп"

  print 'Введите цену: '
  price = STDIN.gets.to_f

  print 'Введите кол-во: '
  quantity = STDIN.gets.to_f
  puts

  products[title] = {price: price, quantity: quantity}
end

puts

rows = []
final_price = 0

products.each do |var|
  title = var[0]
  price = var[1][:price]
  quantity = var[1][:quantity]
  full_price = price * quantity
  final_price += full_price

  rows << [title, price, quantity, full_price]
end

table = Terminal::Table.new :title => 'Ваша корзина',
                            :headings => ['Название товара', 'Стоимость', 'Кол-во', 'Полная цена'],
                            :rows => rows,
                            :style => {:width => 80}

puts table
puts
puts "Итого: #{final_price}"
