module RademadeAdmin
  module CrudController

    #Methods (Instance methods)
    include RademadeAdmin::CrudController::Saver
    include RademadeAdmin::CrudController::Search
    include RademadeAdmin::CrudController::Linker
    include RademadeAdmin::CrudController::Templates
    include RademadeAdmin::CrudController::InstanceOptions

    def filter_data_params(params)
      params.require(:data).permit(save_form_fields)
    end

    # Creates a hash for Mongoid::Criteria
    #
    # Params:
    #   - params {Hash} with user-input search criteria
    #
    # Examples:
    #
    #   build_search_params({ 'id_eq' => '123', 'name_in' => ['Vlad', 'Den'] })
    #   #=> {id: 123, :'name.in' => ['Vlad', 'Den']}
    #
    # Returns {Hash}
    def build_search_params(params = {})
      criteria_hash = {}

      if params
        predicates = ['_in', '_eq']

        params.each do |key, value|
          field = key.to_s
          predicates.each { |x| field = field.gsub(x, '') }

          if origin_fields.include?(field)
            new_key = field.to_sym # 'name'+'.in' => :'name.in'
            new_key = new_key.in if key.to_s.include?('_in') # todo remove hard code

            criteria_hash[new_key] = multiple?(key) ? Array.wrap(value) : value
          end
        end
      end

      criteria_hash
    end

    def multiple?(key)
      key.to_s.include? '_in'
    end

    # Priority I
    def self.included(base)
      base.extend RademadeAdmin::ModelConfiguration
      #Load fields, copy options to instance
      base.before_filter :load_options #rm_todo move load_options to self classes
    end

  end
end
