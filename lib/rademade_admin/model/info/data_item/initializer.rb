# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem
        class Initializer

          def auto
            return from_relation if @relation
            return form_field if @field
            raise 'No relation and field given for DateItem initialization' #TODO custom exception
          end

          def from_relation
            build(@relation.name, @relation.foreign_key)
          end

          def form_field
            name = @field.name
            build(name, name)
          end

          def build(name, order_column)
             RademadeAdmin::Model::Info::DataItem.new(name, @field, @relation, order_column)
          end

          protected

          def initialize(field, relation)
            @field, @relation = field, relation
          end

        end
      end
    end
  end
end
