# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem

        attr_accessor :name,
                      :field,
                      :relation,
                      :label,
                      :form_position,
                      :list_position,
                      :has_uploader

        attr_writer :in_form,
                    :form_params,
                    :in_list,
                    :preview_accessor

        #
        # @param name [Symbol]
        # @param field [RademadeAdmin::Model::Info::Field]
        # @param relation [RademadeAdmin::Model::Info::Relation]
        # @param has_uploader [Boolean]
        #
        def initialize(name, field = nil, relation = nil, has_uploader = false)
          @name = name
          @field = field
          @relation = relation
          @has_uploader = has_uploader
          @in_list = false
          @in_form = false
          @form_params = nil
          @preview_accessor = nil
          #rm_todo pry.binding if not has_relation? and @field.nil? create custom notification
        end

        def has_name?(name)
          (has_relation? and @relation.name == name) or (has_field? and @field.name == name)
        end

        def has_relation?
          not @relation.nil?
        end

        def has_field?
          not @field.nil?
        end

        def has_uploader?
          has_uploader
        end

        def date_time?
          has_field? and @field.is_date_time
        end

        def sortable_relation?
          @relation.sortable?
        end

        def localizable?(localizable = true)
          if not @form_params.nil? and @form_params.has_key? :localize
            @form_params[:localize] == localizable
          else
            return !localizable unless has_field?
            field.localizable == localizable
          end
        end

        def label
          @label ||= _default_label
        end

        def getter
          @getter ||= _getter
        end

        def setter
          @setter ||= :"#{getter}="
        end

        def preview_accessor
          @preview_accessor.nil? ? getter : @preview_accessor
        end

        def in_list?
          @in_list
        end

        def in_form?
          @in_form
        end

        def form_params
          @form_params.nil? ? {} : @form_params
        end

        def primary_field?
          @field and @field.primary?
        end

        def string_field?
          @field and @field.type == String
        end

        def simple_field?
          not(has_uploader? or has_relation?)
        end

        private

        def _default_label
          name.to_s.humanize
        end

        def _getter
          return @relation.name if has_relation?
          return @field.name if has_field?
          name
        end

      end
    end
  end
end