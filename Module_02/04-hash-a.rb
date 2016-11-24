puts 'Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1)'
puts

dictionary = ('a'..'z').to_a
letters = ["a", "e", "i", "o", "u", "y"]

new_dictionary = {}

dictionary.each_with_index do |letter, idx|
  new_dictionary[letter] = idx + 1 if letters.include?(letter)
end

p new_dictionary
