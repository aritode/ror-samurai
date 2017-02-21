# frozen_string_literal: true
class CargoCarriage < Carriage
  attr_reader :capacity_taken

  def initialize(capacity)
    @full_capacity = capacity
    @capacity_taken = 0
    valid!
    super(:cargo)
  end

  def take_capacity(amount)
    raise 'Не хватает обьема в вагоне' if capacity_available < amount
    @capacity_taken += amount
  end

  def capacity_available
    @full_capacity - @capacity_taken
  end

  def show
    puts "#Номер вагона: #{id}. Тип: #{type}. Свободный обьем: #{capacity_available} " \
         "Занятый обьем: #{capacity_taken}"
  end

  def take
    print 'Введите добавляемый обьем: '
    user_input = STDIN.gets.to_i
    take_capacity(user_input)
    puts "Обьем #{user_input} успешно добавлен в вагон №#{@id}."
  end

  def valid!
    raise 'Некорректное количество мест' if @full_capacity <= 0
    true
  end
end
