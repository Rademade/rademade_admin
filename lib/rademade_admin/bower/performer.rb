require 'bower-rails/performer'

module RademadeAdmin
  module Bower
    class Performer < BowerRails::Performer

      def bower_root_path
        @root_path ||= RademadeAdmin::Engine.root.to_s
      end

    end
  end
end