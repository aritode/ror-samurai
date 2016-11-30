# encoding: utf-8
#
# Simple 3 Classes for Trains

require_relative 'train'
require_relative 'route'
require_relative 'station'


train_passenger = Train.new(25, :passenger, 15)
train_passenger_2 = Train.new(12, :passenger, 10)
train_cargo = Train.new(88, :cargo, 35)

# =========== #

train = Train.new(01, :passenger, 20)

puts "Показывает текущую скрость"

3.times { train.speed_up }
puts '---'
puts "Train speed: #{train.speed}"


puts "Показывает количество вагонов"
train.add_carriage
puts train.carriage_count

3.times { train.delete_carriage }
puts
puts train.carriage_count
puts
4.times { train.speed_down }
puts
5.times { train.delete_carriage }
puts
puts "Кол-во вагонов: #{train.carriage_count}"


# =========== #

msk = Station.new("Москва")
spb = Station.new("СПб")

nov = Station.new("Новгород")
smo = Station.new("Смоленск")
tver = Station.new("Тверь")

railway_tour = Route.new(msk, spb)

railway_tour.add(nov)
railway_tour.add(smo)
railway_tour.add(tver)

railway_tour

railway_tour.show_all

# ============ #

msk.show_all_trains
puts
msk.train_in(train)
msk.show_all_trains
puts
msk.train_in(train_passenger)
msk.train_in(train_passenger_2)
msk.train_in(train_cargo)
msk.show_all_trains

puts
msk.show_by_type(:cargo)
puts
msk.show_by_type(:passenger)

# ============= #

railway_tour.add(smo)
railway_tour.delete(smo)
railway_tour.show_all
puts

railway_tour.delete(spb)

puts

train_passenger.route = railway_tour
puts
puts '======================'
puts
# p "Текущая станция: #{train_passenger.location[:now].name}"
# p "Текущая станция: #{train_passenger.location[:now].name}"
puts
puts '======================'
puts
train_passenger.move_next
puts
puts '======================'
puts
train_passenger.station_now
train_passenger.station_next
train_passenger.station_previous
puts
puts '======================'
puts
train_passenger.move_next
train_passenger.move_next
puts
puts '======================'
puts
train_passenger.station_now
train_passenger.station_next
train_passenger.station_previous
puts
puts '======================'
puts
train_passenger.move_next
train_passenger.move_next
# p railway_tour.all



