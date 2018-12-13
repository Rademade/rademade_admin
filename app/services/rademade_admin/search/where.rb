module RademadeAdmin
  module Search
    module Where

      protected

      def regex_filter(where_conditions, search)
        if search.present? and not @data_items.filter_fields.empty?
          query_where = RademadeAdmin::Search::Part::Where.new(:or)
          @data_items.filter_fields.each do |field|
            query_where.add(field, /#{search}/i)
          end
          where_conditions.sub_add(query_where)
        end
        where_conditions
      end

    end
  end
end