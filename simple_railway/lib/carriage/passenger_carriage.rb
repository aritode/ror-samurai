class PassengerCarriage < Carriage

  attr_reader :seats_taken

  def initialize(seats)
    @seats_all = seats
    @seats_taken = 0
    valid!
    super(:passenger)
  end

  def take_seat
    if @seats_taken == @seats_all
      raise 'Не хватает места в вагоне'
    end
    @seats_taken += 1
  end

  def take
    take_seat
    puts "1 место занято в вагоне №#{@id}."
  end

  def seats_available
    @seats_all - @seats_taken
  end

  def show
    puts "#Номер вагона: #{id}. Тип: #{type}. Свободно мест: #{seats_available} Занято мест: #{@seats_taken}"
  end

  def valid!
    raise 'Некорректное количество мест' if @seats_all <= 0
    true
  end
end
