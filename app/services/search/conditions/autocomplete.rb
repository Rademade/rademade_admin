# -*- encoding : utf-8 -*-
require 'search/conditions/abstract'
require 'search/where'

module RademadeAdmin
  module Search
    module Conditions
      class Autocomplete < Abstract

        include RademadeAdmin::Search::Where

        protected

        def where
          @where_conditions = RademadeAdmin::Search::Part::Where.new(:and)
          regex_filter(@where_conditions, @params[:q])
          append_search_params
          append_ids_params
          @where_conditions
        end

        def limit
          10
        end

        private

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
