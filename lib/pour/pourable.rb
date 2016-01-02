module Pour
  module Pourable
    module ClassMethods
    end

    module InstanceMethods
    end

    def self.included(pourable)
      pourable.send :include, Pour::Propertied

      pourable.send :extend, ClassMethods
      pourable.send :include, InstanceMethods
    end
  end
end
