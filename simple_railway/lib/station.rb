# frozen_string_literal: true
require_relative 'modules/validation'

class Station
  extend Validation
  attr_reader :name, :trains

  validate :name, :presence

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
  end

  def train_in(train)
    raise 'Поезд уже на данной станции' if @trains.include?(train)
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
      show_trains
    end
  end

  def show_trains_by_type(arg)
    puts "Поездов на станции по типу: #{arg}"
    list = all_trains.select { |train| train.type == arg }
    if list.any?
      list.each(&:show)
    else
      puts 'Пусто'
    end
  end

  def all_trains(&block)
    @trains.each(&block)
  end

  def show_trains
    all_trains(&:show)
  end
end
