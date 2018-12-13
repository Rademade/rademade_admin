# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data
        class ActiveRecordData < RademadeAdmin::Model::Adapter::Data

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
                relations[name] = _relation_class_name(to_class).new({
                  :name => name,
                  :from => @model,
                  :to => to_class,
                  :destroyable => _relation_destroyable?(relation_info),
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

          def _relation_destroyable?(relation_info)
            !_validates_association?(relation_info) &&
              !_validates_presence?(relation_info)
          end

          def _validates_association?(relation_info)
            _model_validates?(@model,
                             relation_info.name,
                             ::ActiveRecord::Validations::AssociatedValidator)
          end

          def _validates_presence?(relation_info)
            _model_validates?(relation_info.klass,
                             relation_info.foreign_key,
                             ::ActiveRecord::Validations::PresenceValidator)
          end

          def _model_validates?(model, name, validator_class)
            model.validators.select do |validator|
              validator.class == validator_class &&
                validator.attributes.include?(name)
            end.any?
          end

          def _add_non_localizable_fields(fields)
            @model.attribute_types.each do |field_name, field_data|
              name = field_name.to_sym
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => @model.primary_key == field_name,
                :getter => name,
                :setter => :"#{name}=",
                :type => field_type(extract_column_data(field_data).type),
                :localizable => false,
                :relation_name => name[/(.+)_id$/, 1]
              })
            end
            fields
          end

          def _add_localizable_fields(fields)
            @model.try(:translated_attribute_names).each do |name|
              name = name.to_sym
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => false,
                :getter => name,
                :setter => :"#{name}=",
                :localizable => true
              })
            end if @model.respond_to?(:translation_class)
            fields
          end

          def _model_uploaders
            return super unless @model.respond_to?(:translation_class)
            super.merge(@model.translation_class.uploaders)
          end

          def _model_fields
            @model.attribute_types.keys.map(&:to_sym)
          end

          private

          def field_type(type)
            case type
              when :string
                RademadeAdmin::Model::Info::Field::Type::STRING
              when :boolean
                RademadeAdmin::Model::Info::Field::Type::BOOLEAN
              when :date
                RademadeAdmin::Model::Info::Field::Type::DATE
              when :datetime
                RademadeAdmin::Model::Info::Field::Type::DATE_TIME
              when :text
                RademadeAdmin::Model::Info::Field::Type::TEXT
            end
          end

          def extract_column_data(field_data)
            if datetime_type?(field_data)
              field_data.instance_values['column']
            else
              field_data
            end
          end

          def datetime_type?(field_data)
            defined?(::ActiveRecord::AttributeMethods::TimeZoneConversion::Type) &&
              field_data.is_a?(::ActiveRecord::AttributeMethods::TimeZoneConversion::Type)
          end

        end
      end
    end
  end
end
