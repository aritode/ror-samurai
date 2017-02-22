# frozen_string_literal: true
module Validation
  def validate(attr_name, type_validation, param = nil)
    instance_variable_set(:@params, {}) unless instance_variable_defined?(:@params)
    params = instance_variable_get(:@params)
    params[type_validation] = [attr_name, param]

    define_method('validate!') do
      params.each do |key, value|
        type = key.to_sym
        var_name = "@#{value[0]}".to_sym
        option = value[1]
        value = instance_variable_get(var_name)

        send type, var_name, value, option
      end
    end

    define_method('valid?') do
      begin
        !!validate!
      rescue
        false
      end
    end

    define_method('presence') do |name, value, _option|
      raise "Параметр #{name} не может быть пустой!" if value.nil? || value.to_s.empty?
    end

    define_method('format') do |name, value, option|
      message = "Необходимо выполнение правила: #{option} - Параметр: #{name}"
      raise message unless value =~ option
    end

    define_method('type') do |name, value, option|
      raise "Неправильный тип #{value.class} для #{name} - Правильный тип: #{option}" unless value.is_a? option
    end
  end
end

# class Test
#   extend Validation
#
#   attr_accessor :name, :test, :number
#
#   validate :name, :presence
#   validate :name, :type, String
#
#   validate :test, :presence
#   validate :test, :format, /[A-Z]+/
#
#   validate :number, :format, /[0-9]+/
# end
#
# abc = Test.new
# abc.name = "Str123123"
# abc.test = "SAAA"
# abc.number = '222'
# abc.validate!
