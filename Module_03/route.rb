class Route
  attr_reader :stations

  def initialize(station_start, station_finish)
    @stations = [station_start, station_finish]
  end

  def add(station)
    if @stations.include?(station)
      puts "Станция #{station.name} уже в списке маршрута."
    else
      @stations.insert(-2, station)
      puts "Станция #{station.name} добавлен(а) в маршрут."
    end
  end

  def delete(station)
    if station == @stations.first || station == @stations.last
      puts 'Нельзя удалить пункты отправления/прибытия'
    else
      puts "Станция #{station.name} удален(а) из маршрута."
      @stations.delete(station)
    end
  end

  def show_all
    puts "Все станции маршрута:"
    @stations.each {|station| puts station.name}
  end
end
