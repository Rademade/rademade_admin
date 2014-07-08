module RademadeAdmin
  module CrudController

    # Methods (Instance methods)
    include RademadeAdmin::CrudController::Linker
    include RademadeAdmin::CrudController::InstanceOptions

    def self.included(base)
      base.extend RademadeAdmin::ModelConfiguration
      # Load fields, copy options to instance
      base.before_filter :load_options #rm_todo move load_options to self classes
    end

  end
end
