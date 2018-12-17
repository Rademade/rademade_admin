# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Persistence
        class ActiveRecordPersistence < RademadeAdmin::Model::Adapter::Persistence

          def new?(record)
            record.new_record?
          end

          def save(record)
            record.save!
          end

        end
      end
    end
  end
end
