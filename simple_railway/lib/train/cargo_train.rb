# frozen_string_literal: true
class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number, :cargo)
  end

  def add_carriage(carriage)
    if carriage.instance_of?(CargoCarriage)
      super
    else
      puts "Нельзя подсоединить - Тип поезда: #{carriage.type}, Тип вагона: #{type}"
    end
  end
end
