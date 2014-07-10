module RademadeAdmin
  module Search
    class Abstract

      attr_reader :params

      def initialize(params, origin_fields)
        @params = params
        @origin_fields = origin_fields
      end

      def conditions
        @conditions ||= init_conditions
      end

      protected

      def init_conditions
        {
          :where => where,
          :order => order,
          :page => page,
          :per_page => per_page,
          :limit => limit
        }
      end

      def where
        {
          :or => {},
          :and => {}
        }
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