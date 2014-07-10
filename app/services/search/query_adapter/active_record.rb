module RademadeAdmin
  module Search
    class ActiveRecord < Abstract

      protected

      def where(where_conditions)
        values = []
        condition = ''
        where_conditions.each do |type, conditions|
          conditions.each do |field, value|
            condition += " #{type.to_s.capitalize} " unless condition.empty?
            if value.is_a? Array
              condition += "#{field} IN (?)"
            else
              condition += "#{field} = ?"
            end
            values << value
          end
        end
        @result.where([condition, *values])
      end

      def order(order_conditions)
        order_conditions.each do |order_condition|
          @result = @result.order(order_condition)
        end
        @result
      end
      
    end
  end
end