module Pour
  class Mould
    module ClassMethods
      def pour(pourable)
        unless pourable.class.included_modules.include?(Pour::Pourable)
          raise Pour::Unpourable.new(pourable)
        end
        poured = self.class_variable_get(:@@__poured__) || []
        unless poured.include? pourable
          self.class_variable_set(:@@__poured__, poured + pourable)
          # This capture all the properties as well as any user-defined methods.
          self.include(pourable)
        end
      end
    end

    module InstanceMethods
    end

    def self.inherited(mould)
      mould.send :extend, ClassMethods
      mould.send :include, InstanceMethods

      # We can assume nothing has been "poured" into |mold|.
      poured = self.class_variable_get(:@@__poured__) || []
      mould.class_variable_set(:@@__poured__, poured)
    end
  end
end
