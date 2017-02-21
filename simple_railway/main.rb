# encoding: utf-8
# frozen_string_literal: true
#
# Trains - RailWay Soft
#

require_relative 'lib/train'
require_relative 'lib/train/cargo_train'
require_relative 'lib/train/passenger_train'
require_relative 'lib/carriage'
require_relative 'lib/carriage/cargo_carriage'
require_relative 'lib/carriage/passenger_carriage'
require_relative 'lib/route'
require_relative 'lib/station'

require_relative 'lib/display_menu'

DisplayMenu.new
