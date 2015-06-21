# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Bootstrap
    class Components

      def validate
        check_globalize
      end

      protected

      def check_globalize
        # Pre conditions
        return false unless defined? Globalize
        return true if version(Rails::VERSION::STRING) < version('4.2')

        # Load globalize/version
        require 'globalize/version'
        raise ComponentException.wrong_globalize if version(Globalize::Version) < version('5.0')
      end

      def version(v)
        Gem::Version.new(v)
      end

    end
  end
end