class RademadeAdmin::Login::Error < Exception

  attr_accessor :field

  def initialize(message, field)
    super message
    @field = field
  end

  def field_messages
    { field.to_sym => message }
  end

end