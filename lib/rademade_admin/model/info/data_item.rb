# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem

        attr_accessor :name, :field, :relation, :label, :form_params,
                      :form_position, :list_position
        attr_writer :is_uploader, :in_form, :in_list
        attr_reader :uploader

        #
        # @param name [Symbol]
        # @param field [RademadeAdmin::Model::Info::Field]
        # @param relation [RademadeAdmin::Model::Info::Relation]
        # @param uploader [RademadeAdmin::Model::Info::Uploader]
        #
        def initialize(name, field = nil, relation = nil, uploader = nil)
          @name, @field, @relation, @uploader = name, field, relation, uploader
          @in_list, @in_form = false, false
        end

        def has_relation?
          not @relation.nil?
        end

        def has_uploader?
          not @uploader.nil?
        end

        def label
          @label ||= _default_label
        end

        def getter
          @getter ||= has_relation? ? @relation.name : @field.name
        end

        def setter
          @setter ||= :"#{getter}="
        end

        def in_list?
          @in_list
        end

        def in_form?
          @in_form
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

      end
    end
  end
end