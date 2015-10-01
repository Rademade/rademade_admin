# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    module Conditions
      class Abstract

        attr_reader :params
        attr_writer :base_items

        # @param params [Hash]
        # @param data_items [RademadeAdmin::Model::Info::DataItems]
        #
        def initialize(params, data_items)
          @params = params
          @data_items = data_items
        end

        def conditions
          @conditions ||= {
            :where => where,
            :order => order,
            :paginate => paginate,
            :limit => limit
          }
        end

        def base_condition(base_items)
          @base_items || base_items
        end

        protected

        def where
          nil
        end

        def order
          order_conditions = RademadeAdmin::Search::Part::Order.new
          order_conditions.add(:id, :desc)
          order_conditions
        end

        def paginate
          if page.nil? || per_page.nil?
            nil
          else
            [page, per_page]
          end
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
