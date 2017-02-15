class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  def add_carriage(carriage)
    if carriage.instance_of?(CargoCarriage)
      super
    else
      puts "Нельзя подсоединить - Тип поезда: #{carriage.type}, Тип вагона: #{self.type}"
    end
  end
end
