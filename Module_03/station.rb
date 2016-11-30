class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_in(train)
    @trains << train
    puts "Поезд - № #{train.number} прибыл на станцию #{@name}."
  end

  def train_out(train)
    @trains.delete(train)
    puts "Поезд - № #{train.number} отправился в пусть со станции #{@name}."
  end

  def show_all_trains
    puts "Поездов на станции:"
    if @trains.empty?
      puts "Пусто"
    else
      @trains.each { |item| puts "Номер поезда - №#{item.number}. Тип: #{item.type}" }
    end
  end

  def show_by_type(arg)
    puts "Поездов на станции по типу: #{arg}"
    list = @trains.select { |train| train.type == arg }
    list.each { |item| puts "Номер поезда - №#{item.number}. Тип: #{item.type}" }
    puts "Кол-во: #{list.size}"
    puts "Всего: #{@trains.size}"
  end
end
