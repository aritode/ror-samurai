puts 'Программа, которая высчитывет площадь треугольника.'
puts

print 'Введите основание треугольника: '
a = STDIN.gets.to_f

print 'Введите высоту треугольника: '
h = STDIN.gets.to_f

area = 0.5 * a * h

puts "Площадь треугольника - #{area}"