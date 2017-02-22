# frozen_string_literal: true
require_relative 'modules/vendor_name.rb'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Carriage
  include VendorName
  include InstanceCounter
  extend Validation

  attr_reader :type, :id

  TYPE_FORMAT = /^(cargo|passenger)$/i

  validate :type, :format, TYPE_FORMAT

  def initialize(type)
    @type = type
    @id = rand(1000)

    validate!
    register_instance
  end

  def take; end
end
