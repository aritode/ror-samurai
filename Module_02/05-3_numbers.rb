puts 'Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).'
puts 'Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.'
puts

months = {january: 31,
          february: 28,
          march: 31,
          april: 30,
          may: 31,
          june: 30,
          july: 31,
          august: 31,
          september: 30,
          october: 31,
          november: 30,
          december: 31
}

def visokos_checker(year, months)
  if year % 400 == 0 || year % 4 == 0
    puts "високосный"
    months[:february] = 29
  elsif year % 100 == 0
    puts "не високосный"
  else
    puts "не високосный"
  end
end

def calc_result(month_range, day)
  month_calc = month_range.map { |idx| idx[1]}
  month_calc << day

  result = 0
  month_calc.each do |var|
    result += var
  end
  result
end

def sum_number_of_days(day, month, year, months)
  visokos_checker(year, months)
  month_range = months.to_a[0..month-2]
  calc_result(month_range, day)
end


print 'Введите число: '
day = STDIN.gets.to_i

print 'Введите номер месяца: '
month = STDIN.gets.to_i

print 'Введите год: '
year = STDIN.gets.to_i

result = sum_number_of_days(day, month, year, months)

# p month_calc
puts
puts "Порядковый номер даты, начиная отсчет с начала года = #{result}"
