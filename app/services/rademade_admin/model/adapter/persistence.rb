# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Persistence

        def initialize(model)
          @model = model
        end

        def new_record
          @model.new
        end

        def new?(record)
          nil
        end

        def save(record, options = {})
          nil
        end

        def destroy(record)
          record.destroy
        end

      end
    end
  end
end
