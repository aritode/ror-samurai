class Station
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    valid!
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
  end

  def train_in(train)
    @trains << train
    puts "Поезд - № #{train.number} прибыл на станцию #{@name}."
  end

  def train_out(train)
    @trains.delete(train)
    puts "Поезд - № #{train.number} отправился в путь со станции #{@name}."
  end

  def show_all_trains
    puts "Поездов на станции:"
    if @trains.empty?
      puts "Пусто"
    else
      @trains.each { |train| puts "Номер поезда - №#{train.number}. Тип: #{train.type}. Вагонов: #{train.carriages.size}" }
    end
  end

  def show_by_type(arg)
    puts "Поездов на станции по типу: #{arg}"
    list = @trains.select { |train| train.type == arg }
    list.each { |train| puts "Номер поезда - №#{train.number}. Тип: #{train.type}. Вагонов: #{train.carriages.size}" }
    puts "Кол-во: #{list.size}"
    puts "Всего: #{@trains.size}"
  end

  def all_trains(&block)
    @trains.each &block
  end

  protected

  def valid!
    raise 'Название станции не может быть пустым' if @name.size.zero?
    true
  end
end
