# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Persistence
        class SequelPersistence < RademadeAdmin::Model::Adapter::Persistence

          def initialize(model)
            @model = model
          end

          def new_record
            @model.new
          end

          def new?(record)
            record.new?
          end

          def destroy(record)
            record.destroy
          end

          def save(record, options = {})
            record.save(options)
          end

        end
      end
    end
  end
end
