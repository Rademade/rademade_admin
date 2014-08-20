# -*- encoding : utf-8 -*-
require 'search/conditions/abstract'

module RademadeAdmin
  module Search
    module Conditions
      class Autocomplete < Abstract

        protected

        def where
          @where_conditions = RademadeAdmin::Search::Part::Where.new(:and)
          append_query_condition
          append_search_params
          append_ids_params
          @where_conditions
        end

        def limit
          10
        end

        private

        def append_query_condition
          if @params[:q].present?
            query_where = RademadeAdmin::Search::Part::Where.new(:or)
            @data_items.filter_fields.each do |field|
              query_where.add(field, /#{@params[:q]}/i)
            end
            @where_conditions.sub_add(query_where)
          end
        end

        def append_search_params
          if @params[:search].present?
            @params[:search].each do |key, value|
              @where_conditions.add(key.to_sym, value) if @data_items.origin_fields.include? key.to_s
            end
          end
        end

        def append_ids_params
          if @params[:ids].present?
            @where_conditions.add(@data_items.primary_field.name, @params[:ids])
          end
        end

      end
    end
  end
end
