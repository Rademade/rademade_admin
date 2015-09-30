# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data
        class Mongoid < RademadeAdmin::Model::Adapter::Data

          protected

          def has_many_relations
            [:embeds_many, :has_many, :has_and_belongs_to_many]
          end

          def has_one_relations
            [:has_one, :embeds_one, :belongs_to]
          end

          def _map_fields
            fields = {}
            @model.fields.each do |name, field_data|
              name = name.to_sym
              getter = name.to_s
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => name == :_id,
                :getter => getter,
                :setter => "#{getter}=",
                :is_string => field_data.type == String,
                :is_date_time => field_data.type == DateTime,
                :is_boolean => field_data.type == ::Mongoid::Boolean,
                :localizable => field_data.localized?,
                :relation_name => field_data.options[:metadata].try(:name)
              })
            end
            fields
          end

          def _map_relations
            relations = {}
            @model.relations.each do |name, relation_info|
              name = name.to_sym
              type = relation_info.relation.macro
              is_sortable = relation_info.sortable?
              to_class = RademadeAdmin::LoaderService.const_get(relation_info.class_name) rescue nil
              if !to_class.nil? && to_class.ancestors.include?(RademadeAdmin::Gallery)
                relation_class_name = ::RademadeAdmin::Model::Info::Relation::Gallery
              else
                relation_class_name = ::RademadeAdmin::Model::Info::Relation
              end
              relations[name] = relation_class_name.new({
                :name => name,
                :from => @model,
                :to => to_class,
                :getter => name.to_s,
                :setter => relation_info.setter,
                :type => type,
                :many => type == :has_many,
                :has_many => has_many_relations.include?(type),
                :sortable => is_sortable,
                :sortable_field => is_sortable ? relation_info.sortable_field : nil,
                :foreign_key => relation_info.foreign_key ? relation_info.foreign_key.to_sym : nil
              })
            end
            relations
          end

          def _model_fields
            @model.fields.keys.map(&:to_sym)
          end

        end
      end
    end
  end
end