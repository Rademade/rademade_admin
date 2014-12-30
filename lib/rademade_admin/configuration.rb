# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Configuration
    class << self
      attr_reader :user_class, :ability_class

      def configure(&block)
        instance_eval &block
      end

      private

      def admin_model(model)
        @user_class ||= model
      end

      def ability_model(model)
        @ability_class ||= model
      end

    end
  end
end
