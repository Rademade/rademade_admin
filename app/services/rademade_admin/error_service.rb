# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ErrorService

    def error_messages_for(error)
      if active_record_error?(error) || mongoid_error?(error)
        error.record.errors
      elsif sequel_error?(error)
        error.errors
      elsif error.is_a?(RademadeAdmin::FieldError)
        error.error_hash
      else
        error.message
      end
    end

    private

    def active_record_error?(error)
      defined?(ActiveRecord::RecordInvalid) && error.is_a?(ActiveRecord::RecordInvalid)
    end

    def mongoid_error?(error)
      defined?(Mongoid::Errors::Validations) && error.is_a?(Mongoid::Errors::Validations)
    end

    def sequel_error?(error)
      defined?(Sequel::ValidationFailed) && error.is_a?(Sequel::ValidationFailed)
    end

  end
end