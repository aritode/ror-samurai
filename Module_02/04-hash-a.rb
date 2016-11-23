puts 'Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1)'
puts

dictionary = ('a'..'z').to_a
letters = ["a", "e", "i", "o", "u", "y"]

new_dictionary = {}
letters_hash = {}
i = 0

dictionary.each_with_index do |idx, var|
  i = var + 1
  new_dictionary[idx] = i
end

letters.each do |var|
  letters_hash[var] = new_dictionary[var]
end

p letters_hash
