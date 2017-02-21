# frozen_string_literal: true
module Validation
  def valid?
    valid!
  rescue
    false
  end
end
