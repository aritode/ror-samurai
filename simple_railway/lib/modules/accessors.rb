# frozen_string_literal: true
module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym

      define_method(name.to_s) { instance_variable_get(var_name) }

      define_method("#{name}=".to_s) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_name_history, []) unless instance_variable_defined?(var_name_history)

        history_vars = instance_variable_get(var_name_history)
        current_var = instance_variable_get(var_name)
        history_vars << current_var
      end

      define_method("#{name}_history".to_s) { instance_variable_get(var_name_history) }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name.to_s) { instance_variable_get(var_name) }

    define_method("#{name}=".to_s) do |value|
      raise 'Не совпадает тип класса!' unless value.class.to_s == class_name.to_s
      instance_variable_set(var_name, value)
    end
  end
end

# class Test
#   extend Accessors
#
#   attr_accessor_with_history :test, :test2, :test3
#   strong_attr_accessor :s, Fixnum
# end
