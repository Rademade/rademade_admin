# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data
        class Sequel < RademadeAdmin::Model::Adapter::Data

          protected

          def has_many_relations
            [:one_to_many, :many_to_many]
          end

          def has_one_relations
            [:one_to_one, :many_to_one, :one_through_one]
          end

          def _map_fields
            fields = {}
            @model.db_schema.each do |name, field_data|
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => field_data[:primary_key],
                :getter => name,
                :setter => :"#{name}=",
                :is_string => field_data[:type] == :string,
                :is_date_time => field_data[:type] == :datetime,
                :is_boolean => field_data[:type] == :boolean,
                :localizable => false,
                :relation_name => name[/(.+)_id$/, 1]
              })
            end
            fields
          end

          def _map_relations
            relations = {}
            @model.association_reflections.each do |name, relation_info|
              to_class = RademadeAdmin::LoaderService.const_get(relation_info[:class_name]) rescue nil
              has_many = has_many_relations.include?(relation_info[:type])
              getter = name
              relations[name] = _relation_class_name(to_class).new({
                :name => name,
                :from => @model,
                :to => to_class,
                :getter => getter,
                :query_getter => :"#{getter}_dataset",
                :setter => has_many ? _to_many_setter(relation_info, getter) : :"#{name}=",
                :type => relation_info[:type],
                :many => relation_info[:type] == :one_to_many,
                :has_many => has_many,
                :sortable => false,
                :foreign_key => relation_info[:key]
              })
            end
            relations
          end

          def _to_many_setter(relation_info, getter)
            Proc.new do |new_items|
              old_items = self.send(getter)
              (old_items - new_items).each do |related_item|
                self.instance_exec(related_item, &relation_info[:remover])
              end
              (new_items - old_items).each do |related_item|
                self.instance_exec(related_item, &relation_info[:adder])
              end
            end
          end

        end
      end
    end
  end
end