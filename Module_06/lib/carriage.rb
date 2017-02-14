require_relative 'modules/vendor_name.rb'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Carriage
  include VendorName
  include InstanceCounter
  include Validation

  attr_reader :type

  TYPE_FORMAT = /^(cargo|passenger)$/i

  def initialize(type)
    @type = type

    valid!
    register_instance
  end

  protected

  def valid!
    raise 'Некорректный тип поезда - Может быть cargo или passenger' if @type !~ TYPE_FORMAT
    true
  end
end


