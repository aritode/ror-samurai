class Train
  include VendorName
  attr_reader :speed, :number, :type

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
  end

  def speed_show
    puts "Train Speed: #{@speed}"
  end

  def speed_up
    @speed += 1
    puts 'Speed up by 1.'
    speed_show
  end

  def speed_down
    if @speed == 0
      puts "You have already #{@speed} speed."
    else
      @speed -= 1
      puts 'Speed down by 1.'
      speed_show
    end
  end

  def carriages_show
    puts "You have: #{@carriages.size} carriage(s)."
  end

  def add_carriage(carriage)
    if @speed == 0 && carriage.type == self.type
      @carriages << carriage
      puts "Carriage added."
      carriages_show
    else
      puts "Can't add carriage! Lower carriage speed to 0."
      speed_show
    end
  end

  def delete_carriage
    if @carriages.size == 0
      puts 'Can\'t delete carriage'
      carriages_show
    elsif @speed == 0
      c = @carriages.pop
      puts "Carriage type: #{c.type} deleted."
      carriages_show
    else
      puts "Can't delete carriage! Lower carriage speed to 0."
      speed_show
    end
  end

  def route=(route)
    @route = route
    @index = 0
    puts 'Добавлен/изменен маршрут на новый'
    puts "Изменен пункт отправления - #{@route.stations[@index].name}"
  end

  def move_next
    if @index == @route.stations.size - 1
      puts 'Вы находитесь на конечной станции'
      return
    end

    puts "Поезд №#{@number} отправляется на следующую станцию"
    3.times { self.speed_up }

    @route.stations[@index].train_out(self)

    3.times { self.speed_down }
    @index += 1

    @route.stations[@index].train_in(self)
    puts 'Поезд прибыл на конечную станцию' if @index == @route.stations.size - 1
  end

  def station_next
    if @index != @route.stations.size - 1
      puts "Следующая станция - #{@route.stations[@index + 1].name}"
    else
      puts 'Поезд находится на конечной станции'
    end
  end

  def station_previous
    if @index != 0
      puts "Предыдущая станция - #{@route.stations[@index - 1].name}"
    else
      puts 'Поезд находится на станции отправления'
    end
  end

  def station_now
    puts "Текущая станция - #{@route.stations[@index].name}"
  end
end
