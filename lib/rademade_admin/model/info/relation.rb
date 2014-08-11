# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Relation

        attr_reader :name, :form, :to, :id_setter, :setter, :id_getter, :getter, :type

        def many?
          @has_many
        end

        protected

        # Initialization for Relation info
        #
        # Required options in Hash :name, :form, :to, :setter, :has_many
        # @param opt [Hash]
        #
        def initialize(opt = {})
          @name = opt[:name]
          @form = opt[:form]
          @to = opt[:to]
          @id_setter = opt[:id_setter]
          @setter = opt[:setter]
          @id_getter = opt[:id_getter]
          @getter = opt[:getter]
          @type = opt[:type]
          @has_many = opt[:has_many]
        end

      end
    end
  end
end