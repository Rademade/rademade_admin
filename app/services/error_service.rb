# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ErrorService

    def error_messages_for(error)
      case error
        when ActiveRecord::RecordInvalid, Mongoid::Errors::Validations
          error.record.errors
        when Sequel::ValidationFailed
          error.errors
        else
          error.message
      end
    end

  end
end