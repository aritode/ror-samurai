puts 'Программа, которая считает идеальный вес'
puts

print 'Введите Ваше имя: '
name = STDIN.gets.chomp

print 'Введите Ваш рост: '
height = STDIN.gets.to_i

ideal_weight = height - 110

if ideal_weight > 0
  puts "#{name.capitalize}, Ваш идеальный вес - #{ideal_weight} кг."
else
  puts 'Ваш вес уже оптимальный'
end
