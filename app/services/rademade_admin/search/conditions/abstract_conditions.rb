# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    module Conditions
      class AbstractConditions

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

        def paginate=(paginate)
          conditions[:paginate] = paginate
        end

        protected

        def where
          nil
        end

        def order
          order_conditions = RademadeAdmin::Search::Part::Order.new
          order_conditions.add(@data_items.primary_field.name, :desc)
          order_conditions
        end

        def paginate
          if page.nil? || per_page.nil?
            nil
          else
            [page.to_i, per_page.to_i]
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
