module Pour
  module Pourable
    module ClassMethods
      def property(name, typespec)
        if self.__properties__.map(&:name).include?(name)
          raise "Already have a property called '#{name}'!"
        end

        property = Pour::Property.new(name: name, typespec: typespec)
        self.__properties__ = self.__properties__ + property

        decorated = "@#{name}".to_sym
        reader = name.to_sym
        writer = "#{name}=".to_sym

        self.class_eval do
          define_method reader do
            self.insance_variable_get(decorated)
          end

          define_method writer do |new_value|
            if property.typespec.valid?(new_value)
              self.insance_variable_set(decorated, new_value)
            else
              # TODO(mtwilliams): recursively map to determine where and why the
              # |new_value| doesn't match the typespec.
              raise ":("
            end
          end
        end
      end

      def __properties__
        if self.class.superclass.included_modules.include? Pour::Pourable
          properties = self.class.superclass.class_variable_get(:@@__properties__)
          self.class_variable_set(:@@__properties__, properties)
        end

        self.class_variable_get(:@@__properties__)
      end

      def __properties__=(properties)
        self.class_variable_set(:@@__properties__, properties)
      end
    end

    module InstanceMethods
    end

    def self.included(pourable)
      pourable.send :extend, ClassMethods
      pourable.send :include, InstanceMethods

      pourable.class_variable_set :@@__properties__, []
    end
  end
end
