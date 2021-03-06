class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end

  def add_carriage(carriage)
    if carriage.instance_of?(PassengerCarriage)
      super
    else
      puts "Нельзя подсоединить - Тип поезда: #{carriage.type}, Тип вагона: #{self.type}"
    end
  end
end
