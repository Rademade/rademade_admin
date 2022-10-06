module RademadeAdmin
  module Hideable

    STATUS_HIDDEN = 0
    STATUS_SHOWN = 1

    def method_missing(name, *arguments)
      if %w(status status=).include? name
        raise NotImplementedError.new "Implement '#{name}' method"
      end
      super
    end

    def shown?
      item_status = send(:status)
      if item_status.is_a? Fixnum
        item_status == STATUS_SHOWN
      else
        # for boolean values
        item_status
      end
    end

    def show
      send(:status=, STATUS_SHOWN)
    end

    def hide
      send(:status=, STATUS_HIDDEN)
    end

    def toggle
      shown? ? hide : show
    end

  end
end