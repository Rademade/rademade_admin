# encoding: utf-8
module Mongoid
  module Relations
    module Referenced
      class ManyToMany

        class << self

          alias_method :original_valid_options, :valid_options

          def valid_options
            original_valid_options << :sortable
          end

        end

      end
    end
  end
end