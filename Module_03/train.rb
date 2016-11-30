class Train
  attr_reader :speed, :carriage_count, :number, :type

  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @index
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

  def add_carriage
    if @speed == 0
      @carriage_count += 1
      puts "Carriage added. You have #{@carriage_count} left."
    else
      puts "Can't add carriage! Lower train speed to 0."
      speed_show
    end
  end

  def delete_carriage
    if @carriage_count == 0
      puts "Zero carriages left in train. You have #{@carriage_count} left."
    elsif @speed == 0
      @carriage_count -= 1
      puts "Carriage deleted. You have #{@carriage_count} left."
    else
      puts "Can't add carriage! Lower train speed to 0."
      speed
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
      return nil
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
    if @index == @route.stations.size - 1
      inline = 'Нет (Вы сейчас находитесь на конечной станции)'
    else
      inline = @route.stations[@index + 1].name
    end
    puts "Следующая станция - #{inline} "
  end

  def station_previous
    if @index == 0
      inline = 'Нет (Вы сейчас находитесь на станции отправления)'
    else
      inline = @route.stations[@index - 1].name
    end
    puts "Предыдущая станция - #{inline} "
  end

  def station_now
    inline = @route.stations[@index].name
    puts "Станция на которой находится поезд - #{inline} "
  end
end
