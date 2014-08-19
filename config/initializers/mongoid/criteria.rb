# encoding: utf-8
module Mongoid
  class Criteria

    def add_filter(&block)
      filter_callbacks << block
      self
    end

    def each
      sort_with_position(super(){}).each do |doc|
        yield(doc) if block_given?
      end
    end

    private

    def sort_with_position(items)
      filter_callbacks.each do |filter_callback|
        items = filter_callback.call items
      end unless has_additional_order?
      items
    end

    def filter_callbacks
      @filter_callbacks ||= []
    end

  end
end