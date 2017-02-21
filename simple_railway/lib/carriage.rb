# frozen_string_literal: true
require_relative 'modules/vendor_name.rb'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Carriage
  include VendorName
  include InstanceCounter
  include Validation

  attr_reader :type, :id

  TYPE_FORMAT = /^(cargo|passenger)$/i

  def initialize(type)
    @type = type
    @id = rand(1000)

    valid!
    register_instance
  end

  def take; end

  protected

  def valid!
    raise 'Некорректный тип поезда - Может быть cargo или passenger' if @type !~ TYPE_FORMAT
    true
  end
end
