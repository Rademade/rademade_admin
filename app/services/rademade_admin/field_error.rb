module RademadeAdmin
  class FieldError < Exception

    def initialize(field, message)
      super(message)
      @field = field
    end

    def error_hash
      { @field => message }
    end

  end
end