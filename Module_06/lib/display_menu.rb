class DisplayMenu
  MAIN_MENU = [
      '- ВЫХОД',
      '- Создать станцию',
      '- Создать поезд',
      '- Добавить вагоны к поезду',
      '- Отцеплять вагоны от поезда',
      '- Поместить поезд на станцию',
      '- Список станций',
      '- Список поездов на станции'
  ]
  WELCOME_MESSAGE = [
      '',
      'Welcome to Trains on Rails!',
      '===========================',
      '',
      'МЕНЮ:',
      '----',
      ''
  ]

  def initialize
    @stations = []
    @trains = []
    choose_step
  end

  def choose_step
    loop do
      WELCOME_MESSAGE.each { |item| puts item }
      MAIN_MENU.each_with_index { |item, idx|  puts "#{idx} #{item}" }
      puts
      print 'Выберите вариант: '
      user_choice = STDIN.gets.chomp.to_i
      check_user_input(user_choice)
    end
  end

  private

  def check_user_input(user_choice)
    case user_choice
      when 0 then abort 'Всего доброго!'
      when 1 then create_station
      when 2 then create_train
      when 3 then add_carriage
      when 4 then delete_carriage
      when 5 then take_train_to_station
      when 6 then show_stations
      when 7 then show_trains_on_station
      else
        puts 'Нет такого пункта'
    end
  end

  def create_station
    print 'Введите название станции: '
    user_input = STDIN.gets.chomp
    @stations << Station.new(user_input)
    puts "Станция #{user_input} успешно добавлена!"
    press_enter_to_continue
    choose_step
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def create_train
    print 'Введите номер поезда: '
    number = STDIN.gets.to_s
    type = user_choose_train_type

    case type
      when :passenger then train = PassengerTrain.new(number)
      when :cargo then train = CargoTrain.new(number)
    end

    @trains << train
    puts "Поезд №#{train.number} тип: #{train.type} создан!"
    press_enter_to_continue
    choose_step
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def add_carriage
    train = user_choose_train
    type = user_choose_train_type

    case type
      when :passenger then carriage = PassengerCarriage.new
      when :cargo then carriage = CargoCarriage.new
    end

    train.add_carriage(carriage)
    press_enter_to_continue
    choose_step
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  end

  def user_choose_train_type
    puts 'Выберите тип: '
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = 0
    until type == 1 || type == 2
      type = STDIN.gets.to_i
    end

    types = { 1 => :passenger, 2 => :cargo}
    types[type]
  end

  def user_choose_train
    puts 'Выберите поезд и введите пункт меню: '
    if @trains.empty?
      puts 'Поездов нет. Создайте первый поезд.'
      press_enter_to_continue
      choose_step
    else
      @trains.each_with_index do |train, index|
        puts "#{index}: Поезд №#{train.number} тип: #{train.type}"
      end
      index = STDIN.gets.to_i
      train = @trains[index]
      train
    end
  end

  def delete_carriage
    train = user_choose_train
    train.delete_carriage
    press_enter_to_continue
    choose_step
  end

  def take_train_to_station
    train = user_choose_train
    puts 'Выберите станцию, на которую переместить поезд: '
    if @stations.any?
      @stations.each_with_index { |station, idx| puts "#{idx}. #{station.name}"}
    else
      puts 'Станций нет. Создайте первую станцию.'
    end
    user_idx = STDIN.gets.to_i
    @stations[user_idx].train_in(train)
    press_enter_to_continue
    choose_step
  end

  def show_stations
    if @stations.any?
      @stations.each_with_index { |station, idx| puts "#{idx}. #{station.name}"}
    else
      puts 'Станций нет. Создайте первую станцию.'
    end
    press_enter_to_continue
    choose_step
  end

  def show_trains_on_station
    if @stations.any?
      puts 'Выберите станцию на которой посмотреть список поездов: '
      @stations.each_with_index { |station, idx| puts "#{idx + 1}. #{station.name}"}
      user_idx = STDIN.gets.to_i

      if user_idx <= @stations.size

        station = @stations[user_idx - 1]
        station.show_all_trains
      else
        puts 'На станции нет поездов.'
      end
    else
      puts 'Станций нет. Создайте первую станцию.'
    end

    press_enter_to_continue
    choose_step
  end

  def press_enter_to_continue
    puts
    print 'Press ENTER to continue...'
    STDIN.gets
  end
end
