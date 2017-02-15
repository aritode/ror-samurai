class PassengerCarriage < Carriage

  attr_reader :seats_taken

  def initialize(seats)
    @seats_all = seats
    @seats_taken = 0
    valid!
    super(:passenger)
  end

  def take_seat
    if seats_available < amount
      raise 'Не хватает места в вагоне'
    end
    @seats_taken += 1
  end

  def seats_available
    @seats_all - @seats_taken
  end

  def valid!
    raise 'Некорректное количество мест' if @seats_all <= 0
    true
  end
end
