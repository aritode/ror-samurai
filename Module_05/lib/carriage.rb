class Carriage
  include VendorName
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

