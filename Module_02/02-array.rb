puts 'Заполнить массив числами от 10 до 100 с шагом 5'
puts

array = (10..100).step(5).map {|i| i}

array_new = []

(10..100).each { |i| array_new << i if i % 5 == 0 }

array_three = (10..100).select { |i| i if i % 5 == 0 }

print array
puts
print array_new
puts
print array_three
