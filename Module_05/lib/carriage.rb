require_relative 'modules/vendor_name.rb'
require_relative 'modules/instance_counter'

class Carriage
  include VendorName
  include InstanceCounter
  attr_reader :type

  def initialize(type)
    @type = type
    register_instance
  end
end

