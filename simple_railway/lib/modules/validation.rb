# frozen_string_literal: true
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :params

    private

    attr_writer :params

    def validate(attr_name, type_validation, param = nil)
      @params ||= {}
      params[type_validation] ||= []
      @params[type_validation] << [attr_name, param]
    end
  end

  module InstanceMethods
    def validate!
      parameters = self.class.params
      # &. - safe navigation from ruby -v 2.3.0
      parameters&.each do |key, value|
        type = key.to_sym
        value.each do |item|
          var_name = item[0].to_sym
          option = item[1]
          value = instance_variable_get("@#{var_name}")
          send type, var_name, value, option
        end
      end
    end

    def valid?
      !!validate!
    rescue
      false
    end

    protected

    def presence(name, value, _option)
      raise "Параметр #{name} не может быть пустой!" if value.nil? || value.to_s.empty?
    end

    def format(name, value, option)
      message = "Необходимо выполнение правила: #{option} - Параметр: #{name}"
      raise message unless value =~ option
    end

    def type(name, value, option)
      raise "Неправильный тип #{value.class} для #{name} - Правильный тип: #{option}" unless value.is_a? option
    end
  end
end

# class Test
#   include Validation
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
# abc.number = '22A2'
# abc.validate!
