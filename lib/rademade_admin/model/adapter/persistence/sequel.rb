# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Persistence
        class Sequel < RademadeAdmin::Model::Adapter::Persistence

          def new?(record)
            record.new?
          end

          def save(record)
            record.save_changes
          end

        end
      end
    end
  end
end