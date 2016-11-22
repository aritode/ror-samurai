puts 'Квадратное уравнение.'
puts 'Пользователь вводит 3 коэффициента a, b и с. Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран.'
puts

print 'Введите коэффициент "a": '
a = STDIN.gets.to_f

print 'Введите коэффициент "b": '
b = STDIN.gets.to_f

print 'Введите коэффициент "c": '
c = STDIN.gets.to_f


def show_discriminant(a, b, c)
  discriminant = b ** 2 - 4 * a * c
  puts "Дискриминант = #{discriminant}"
  discriminant
end

def calculate_x1_x2(discriminant, a, b)
  if discriminant == 0
    x1 = ( Math.sqrt(discriminant) - b ) / ( 2 * a )
  elsif discriminant > 0
    x1 = ( Math.sqrt(discriminant) - b ) / ( 2 * a )
    x2 = ( Math.sqrt(discriminant) + b ) * ( -1 ) / ( 2 * a )
  end

  show_x1_x2(discriminant, a, b)
end


def show_x1_x2(discriminant, x1, x2)
  case
    when discriminant < 0
      puts 'Корней нет!'
    when discriminant == 0
      puts "Корень x1, x2 = #{x1}"
    when discriminant > 0
      puts "Корень x1 = #{x1}"
      puts "Корень x2 = #{x2}"
  end
end


def show_result(a, b, c)
  discriminant = show_discriminant(a, b, c)
  calculate_x1_x2(discriminant, a, b)
end

show_result(a, b, c)