# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem

        attr_accessor :name, :field, :relation, :label, :form_params,
                      :form_position, :in_form, :list_position, :in_list

        #
        # @param name [Symbol]
        # @param field [RademadeAdmin::Model::Info::Field]
        # @param relation [RademadeAdmin::Model::Info::Relation]
        #
        def initialize(name, field, relation)
          @name, @field, @relation = name, field, relation
        end

        def has_relation?
          not @relation.nil?
        end

        def label
          @label ||= _default_label
        end

        def getter
          @getter ||= has_relation? ? @relation.name : @field.name
        end

        def in_list?
          in_list.nil? ? false : in_list
        end

        def in_form?
          in_form.nil? ? false : in_form
        end

        def as
          #
        end

        private

        def _default_label
          name.to_s.humanize
        end

      end
    end
  end
end