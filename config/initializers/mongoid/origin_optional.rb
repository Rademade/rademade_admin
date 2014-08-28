# encoding: utf-8
module Origin
  module Optional

    alias_method :original_order_by, :order_by

    def order_by(*spec)
      @additional_order = (not klass.default_scopable? or scoped?)
      original_order_by(*spec)
    end

    def prepend_order_by(*spec)
      option(spec) do |options, query|
        spec.compact.each do |criterion|
          criterion.__sort_option__.each_pair do |field, direction|
            add_sort_option(options, field, direction, true)
          end
          query.pipeline.push('$sort' => options[:sort]) if aggregating?
        end
      end
    end
    alias :prepend_order :prepend_order_by

    def has_additional_order?
      defined?(@additional_order) ? @additional_order : false
    end

    private

    def add_sort_option(options, field, direction, prepend = false)
      if driver == :mongo
        sorting = (options[:sort] || []).dup
        sort_params = [field, direction]
        prepend ? sorting.unshift(sort_params) : sorting.push(sort_params)
      else
        sorting = (options[:sort] || {}).dup
        prepend ? sorting = {field => direction}.merge(sorting) : sorting[field] = direction
      end
      options.store(:sort, sorting)
    end

  end
end