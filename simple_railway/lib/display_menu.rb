class DisplayMenu
  MAIN_MENU = [
      '- ВЫХОД',
      '- Создать станцию',
      '- Создать поезд',
      '- Добавить вагоны к поезду',
      '- Отцеплять вагоны от поезда',
      '- Поместить поезд на станцию',
      '- Список станций',
      '- Список поездов на станции',
      '- Занять место или обьем в вагоне',
      '- Список вагонов',
      '- Список поездов на станции по типу'
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
    # @stations = []
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
      when 8 then take_seat_or_capacity
      when 9 then show_seats_or_capacity
      when 10 then show_trains_on_station_by_type
      else
        puts 'Нет такого пункта'
    end
  end

  def create_station
    print 'Введите название станции: '
    user_input = STDIN.gets.chomp
    Station.new(user_input)
    puts "Станция #{user_input} успешно добавлена!"
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  ensure
    press_enter_to_continue
  end

  def create_train
    print 'Введите номер поезда: '
    number = STDIN.gets.to_s.chomp
    type = user_choose_train_type

    case type
      when :passenger then train = PassengerTrain.new(number)
      when :cargo then train = CargoTrain.new(number)
      else raise 'Ошибка типа вагона'
    end

    @trains << train
    puts "Поезд №#{train.number} тип: #{train.type} создан!"
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  ensure
    press_enter_to_continue
  end

  def add_carriage
    train = user_choose_train
    type = user_choose_train_type
    capacity = user_choose_carriage_capacity

    case type
      when :passenger then carriage = PassengerCarriage.new(capacity)
      when :cargo then carriage = CargoCarriage.new(capacity)
      else raise 'Ошибка типа вагона'
    end

    train.add_carriage(carriage)
  rescue StandardError => e
    puts "Error: #{e.message}"
    retry
  ensure
    press_enter_to_continue
  end

  def user_choose_carriage_capacity
    print 'Введите максимальный обьем места в вагоне: '
    capacity = STDIN.gets.to_i
  end

  def user_choose_train_type
    puts 'Выберите тип: '
    puts '1. Пассажирский'
    puts '2. Грузовой'
    type = 0
    type = STDIN.gets.to_i until type == 1 || type == 2
    types = { 1 => :passenger, 2 => :cargo}
    types[type]
  end

  def user_choose_train
    puts 'Выберите поезд: '
    if @trains.empty?
      puts 'Поездов нет. Создайте первый поезд.'
      press_enter_to_continue
      choose_step
    else
      @trains.each_with_index do |train, index|
        puts "#{index}: Поезд №#{train.number} тип: #{train.type} кол-во вагонов: #{train.carriages.size}"
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
  end

  def take_train_to_station
    train = user_choose_train
    puts 'Выберите станцию, на которую переместить поезд: '
    show_stations_info
    user_idx = STDIN.gets.to_i
    Station.all[user_idx].train_in(train)
  rescue RuntimeError => e
    puts "Error: #{e.message}"
  rescue NoMethodError => e
    puts 'Создайте первую станцию.'
  ensure
    press_enter_to_continue
  end

  def show_stations_info
    if Station.all.any?
      Station.all.each_with_index { |station, idx| puts "#{idx}. #{station.name}"}
    else
      puts 'Станций нет. Создайте первую станцию.'
    end
  end

  def show_stations
    show_stations_info
    press_enter_to_continue
  end

  def show_trains_on_station
    if Station.all.any?
      puts 'Выберите станцию на которой посмотреть список поездов: '
      Station.all.each_with_index { |station, idx| puts "#{idx}. #{station.name}"}
      user_idx = STDIN.gets.to_i
      if user_idx <= Station.all.size
        station = Station.all[user_idx]
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

  def show_trains_on_station_by_type
    if Station.all.any?
      puts 'Выберите станцию на которой посмотреть список поездов: '
      Station.all.each_with_index { |station, idx| puts "#{idx}. #{station.name}"}
      user_idx = STDIN.gets.to_i
      if user_idx <= Station.all.size
        station = Station.all[user_idx]
        type = user_choose_train_type
        station.show_trains_by_type(type)
      else
        puts 'На станции нет поездов.'
      end
    else
      puts 'Станций нет. Создайте первую станцию.'
    end

    press_enter_to_continue
    choose_step
  end

  def take_seat_or_capacity
    train = user_choose_train

    if train.carriages.size == 0
      puts 'Нет вагонов'
      press_enter_to_continue
      choose_step
    else
      train.show_carriages
    end

    print 'Введите номер вагона: '
    user_choice = STDIN.gets.to_i
    user_carriage = train.all_carriages.select {|carriage| carriage if user_choice == carriage.id}.first
    user_carriage.take
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  ensure
    press_enter_to_continue
  end

  def show_seats_or_capacity
    train = user_choose_train
    if train.carriages.size > 0
      train.show_carriages
    else
      puts 'Нет вагонов'
    end
  rescue RuntimeError => e
    puts "Error: #{e.message}"
    retry
  ensure
    press_enter_to_continue
  end

  def press_enter_to_continue
    puts
    print 'Нажмите Enter для перехода в главное меню...'
    STDIN.gets
  end
end
