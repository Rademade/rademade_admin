# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem

        # TODO extract sub classes

        attr_accessor :name, :field, :relation, :label, :uploader, :order_column, :form_params,
                      :form_position, :list_position, :csv_position, :in_form, :in_list, :in_csv,
                      :list_preview_accessor, :list_preview_handler, :csv_preview_accessor, :csv_preview_handler

        #
        # @param name [Symbol]
        # @param field [RademadeAdmin::Model::Info::Field]
        # @param relation [RademadeAdmin::Model::Info::Relation]
        # @param order_column [String]
        #
        def initialize(name, field = nil, relation = nil, order_column = nil)
          @name = name
          @field = field
          @relation = relation
          @order_column = order_column
          @in_list = false
          @in_form = false
          @in_csv = false
        end

        def has_name?(name)
          (has_relation? && @relation.name == name) || (has_field? && @field.name == name)
        end

        def has_relation?
          not @relation.nil?
        end

        def has_field?
          not @field.nil?
        end

        def has_uploader?
          !uploader.nil?
        end

        def sortable_relation?
          @relation.sortable?
        end

        def gallery_relation?
          return false unless @relation
          @relation.gallery?
        end

        def localizable?(localizable = true)
          if !@form_params.nil? && @form_params.has_key?(:localize)
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
          @setter ||= has_relation? ? relation.setter : :"#{getter}="
        end

        def set_data(item, *data)
          if setter.is_a? Proc
            item.instance_exec(*data, &setter)
          else
            item.send(setter, *data)
          end
        end

        def list_preview_accessor
          @list_preview_accessor || getter
        end

        def csv_preview_accessor
          @csv_preview_accessor || getter
        end

        def in_list?
          @in_list
        end

        def in_csv?
          @in_csv
        end

        def in_form?
          @in_form
        end

        def form_params
          @form_params.nil? ? {} : @form_params
        end

        def primary_field?
          has_field? && @field.primary?
        end

        def string_field?
          has_field? && @field.string?
        end

        def boolean_field?
          has_field? && @field.boolean?
        end

        def date_field?
          has_field? && @field.date?
        end

        def date_time_field?
          has_field? && @field.date_time?
        end

        def simple_field?
          !(has_uploader? || has_relation?)
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