module Validation

  def valid?
    valid!
  rescue
    false
  end
end
