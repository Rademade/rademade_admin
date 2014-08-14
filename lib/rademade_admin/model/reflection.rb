# -*- encoding : utf-8 -*-
require 'rademade_admin/model/reflection/data'

module RademadeAdmin
  module Model
    class Reflection
      include RademadeAdmin::Model::Reflection::Data

      attr_reader :model, :controller

      def initialize(model, controller, controller_name, inner)
        @model, @controller, @controller_name, @inner = model, controller, controller_name, inner
      end

      def nested?
        @inner
      end

    end
  end
end
