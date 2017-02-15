class CargoCarriage < Carriage

  attr_reader :capacity_taken

  def initialize(capacity)
    @full_capacity = capacity
    @capacity_taken = 0
    valid!
    super(:cargo)
  end

  def take_capacity(amount)
   if capacity_available < amount
     raise 'Не хватает обьема в вагоне'
   end
    @capacity_taken += amount
  end

  def capacity_available
    @full_capacity - @capacity_taken
  end

  def valid!
    raise 'Некорректное количество мест' if @full_capacity <= 0
    true
  end
end
