module RademadeAdmin
  module Search
    class Mongoid < QueryAdapter

      protected

      def where(where_conditions)
        # todo
        if defined?(::Mongoid::Paranoia) and @model.ancestors.include? ::Mongoid::Paranoia
          where_conditions[:and][:deleted_at] = nil
        end
        method_map = { :or => :or, :and => :where }
        where_conditions.each do |type, conditions|
          conditions.each do |field, value|
            if value.is_a? Array
              field = field.in
            end
            @result = @result.send(method_map[type], field => value)
          end
        end
        @result
      end

      def order(order_conditions)
        order_conditions.each do |order_condition|
          @result = @result.order_by(order_condition)
        end
        @result
      end
      
    end
  end
end