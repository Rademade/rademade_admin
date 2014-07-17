# -*- encoding : utf-8 -*-
require 'search/conditions/abstract'

module RademadeAdmin
  module Search
    module Conditions
      class Autocomplete < Abstract

        def initialize(params, origin_fields, filter_fields)
          super(params, origin_fields)
          @filter_fields = filter_fields
        end

        protected

        def where
          @where_conditions = Where.new(:and)
          append_query_condition
          append_search_params
          @where_conditions
        end

        def limit
          10
        end

        private

        def append_query_condition
          if @params[:q].present?
            query_where = Where.new(:or)
            @filter_fields.each do |field|
              query_where.add(field, /#{@params[:q]}/i)
            end
            @where_conditions.sub_add(query_where)
          end
        end

        def append_search_params
          if @params[:search].present?
            @params[:search].each do |key, value|
              @where_conditions.add(key.to_sym, value) if @origin_fields.include? key.to_s
            end
          end
        end

      end
    end
  end
end
