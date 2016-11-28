class Train
  attr_reader :speed, :carriage_count, :number, :type, :location

  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @location = {}
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

  #принимать маршрут следования (объект класса Route)
  def route=(route)
    @route = route
    @location = { :now => @route.stations.first,
                  :index => 0
    }

    puts 'Добавлен/изменен маршрут на новый'
    puts "Изменен пункт отправления - #{@location[:now].name}"
  end

  def move_next
    if @location[:now] == @route.stations.last
      puts 'Вы находитесь на конечной станции'
      return nil
    end

    puts "Поезд №#{@number} отправляется на следующую станцию"
    @route.stations.each_with_index do | station, idx|
      @location[:index] = idx if station == @location[:now]
    end

    3.times { self.speed_up }

    @location[:now].train_out(self)

    3.times { self.speed_down }

    @location[:index] += 1

    @location[:now] = @route.stations[@location[:index]]
    @location[:now].train_in(self)

    puts 'Поезд прибыл на конечную станцию' if @location[:now] == @route.stations.last
  end

  #Показывать предыдущую станцию, текущую, следующую, на основе маршрута
  def show(param)
    case param
      when :next
        if @location[:now] == @route.stations.last
          inline = 'Нет'
        else
          @location[:next] = @route.stations[@location[:index] + 1]
          inline = @location[:next].name
        end
      when :previous
        if @location[:index] == 0
          inline = 'Нет'
        else
          @location[:previous] = @route.stations[@location[:index] - 1]
          inline = @location[:previous].name
        end
      when :now
        inline = @location[:now].name
    end
    puts "Показать :#{param} станцию - #{inline} "
  end
end
