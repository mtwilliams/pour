module Pour
  class Property
    attr_reader :name
    attr_reader :typespec

    def initialize(name:, typespec:)
      @name = name
      @typespec = typespec
    # @factory = Pour::Factory.from(typespec)
    # @validator = Pour::Validator.from(typespec)
    end
  end
end
