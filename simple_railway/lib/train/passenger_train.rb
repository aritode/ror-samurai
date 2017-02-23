# frozen_string_literal: true
require_relative '../modules/validation'

class PassengerTrain < Train
  include Validation

  attr_reader :type

  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, :passenger)
    validate!
  end

  def add_carriage(carriage)
    if carriage.instance_of?(PassengerCarriage)
      super
    else
      puts "Нельзя подсоединить - Тип поезда: #{carriage.type}, Тип вагона: #{type}"
    end
  end
end
