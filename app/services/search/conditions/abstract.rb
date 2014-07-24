# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    module Conditions
      class Abstract

        attr_reader :params

        # @param params [Hash]
        # @param fields [RademadeAdmin::Model::Info::Fields]
        #
        def initialize(params, fields)
          @params = params
          @fields = fields
        end

        def conditions
          @conditions ||= {
            :where => where,
            :order => order,
            :page => page,
            :per_page => per_page,
            :limit => limit
          }
        end

        def base_condition(model)
          # todo. deleted at?
          # We can't use default scope. It can be patched
          model.unscoped
        end

        protected

        def where
          nil
        end

        def order
          {}
        end

        def page
          nil
        end

        def per_page
          nil
        end

        def limit
          nil
        end

      end
    end
  end
end
