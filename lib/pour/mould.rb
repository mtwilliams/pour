module Pour
  class Mould
    module ClassMethods
      def pour(pourable)
        unless pourable.included_modules.include?(Pour::Pourable)
          # TODO(mtwilliams): Use a custom exceptin type, Pour::Unpourable.
          raise ":("
        end

        poured = self.class_variable_get(:@@__poured__)

        unless poured.include? pourable
          self.class_variable_set(:@@__poured__, poured + [pourable])

          # This capture all the properties as well as any user-defined methods.
          self.include(pourable)
        end
      end
    end

    module InstanceMethods
    end

    def self.inherited(mould)
      mould.send :include, Pour::Propertied

      mould.send :extend, ClassMethods
      mould.send :include, InstanceMethods
      # We can assume nothing has been "poured" into |mold|.
      mould.class_variable_set(:@@__poured__, [])

      mould.define_singleton_method :inherited do |descendent|
        mould.send :include, Pour::Propertied
        descendent.class_variable_set(:@@__properties__, mould.class_variable_get(:@@__properties__))

        descendent.send :extend, ClassMethods
        descendent.send :include, InstanceMethods
        descendent.class_variable_set(:@@__poured__, mould.class_variable_get(:@@__poured__))
      end
    end
  end
end
