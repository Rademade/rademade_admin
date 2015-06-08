# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data

        # Data adapter for active_record
        #
        class ActiveRecord < RademadeAdmin::Model::Adapter::Data

          protected

          def has_many_relations
            [:has_many, :has_and_belongs_to_many]
          end

          def has_one_relations
            [:has_one, :belongs_to]
          end

          def _map_fields
            fields = {}
            _add_non_localizable_fields fields
            _add_localizable_fields fields
          end

          def _map_relations
            relations = {}
            @model.reflections.each do |name, relation_info|
              name = name.to_sym
              type = relation_info.macro
              if name != :translations
                to_class = relation_info.polymorphic? ? nil : RademadeAdmin::LoaderService.const_get(relation_info.class_name)
                is_sortable = relation_info.respond_to?(:sortable?) ? relation_info.sortable? : false
                relations[name] = _relation_class(to_class).new({
                  :name => name,
                  :from => @model,
                  :to => to_class,
                  :getter => name,
                  :setter => :"#{name}=",
                  :type => type,
                  :many => type == :has_many,
                  :has_many => has_many_relations.include?(type),
                  :sortable => is_sortable,
                  :sortable_field => is_sortable ? relation_info.sortable_field : nil,
                  :foreign_key => relation_info.foreign_key.to_sym
                })
              end
            end
            relations
          end

          def _add_non_localizable_fields(fields)
            binding.pry
            @model.column_types.each do |_name, field_data|
              name = _name.to_sym
              type = field_data.type
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => @model.primary_key == _name,
                :getter => name,
                :setter => :"#{name}=",
                :is_string => type == :string,
                :is_date_time => type == :datetime,
                :localizable => false,
                :relation_name => name[/(.+)_id$/, 1] # todo very strange
              })
            end
            fields
          end

          # Integrated with globalize
          # @return info field
          def _add_localizable_fields(fields)
            return fields unless @model.respond_to?(:translation_class)
            @model.try(:translated_attribute_names).each do |name|
              name = name.to_sym
              getter = name.to_s
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => false,
                :getter => getter,
                :setter => :"#{getter}=",
                :is_string => false,
                :localizable => true,
                :relation_name => nil
              })
            end
            fields
          end

          def _model_uploaders
            return super unless @model.respond_to?(:translation_class)
            super.merge(@model.translation_class.uploaders)
          end

          def _model_fields
            @model.column_types.keys.map(&:to_sym)
          end

        end

      end
    end
  end
end
