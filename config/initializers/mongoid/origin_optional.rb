# encoding: utf-8
module Origin
  module Optional

    alias_method :original_order_by, :order_by

    def order_by(*spec)
      @additional_order = (not klass.default_scopable? or scoped?)
      original_order_by(*spec)
    end

    def has_additional_order?
      defined?(@additional_order) ? @additional_order : false
    end

  end
end