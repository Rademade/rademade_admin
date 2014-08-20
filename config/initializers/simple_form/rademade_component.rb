module SimpleForm
  module Components
    module Rademade

    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Rademade)