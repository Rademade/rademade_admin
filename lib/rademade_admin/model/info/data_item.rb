# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem

        attr_accessor :name, :field, :relation, :label, :as, :in_form, :in_list

        alias_method :in_list?, :in_list
        alias_method :in_form?, :in_form

        #
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

        private

        def _default_label
          name.to_s.humanize
        end

      end
    end
  end
end