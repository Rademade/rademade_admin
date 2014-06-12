##
# Class: AutocompleteService
#
# Does search based on the query for autocomplete.
#
# Examples:
#   AutocompleteService.new(model: Training, query: 'worksh',
#                           filter_fields: [:name, :description]).search
module RademadeAdmin
  class AutocompleteService

    def search
      (@query.blank? ? model.limit(5) : model.or(*search_criteria).limit(10))
    end

    private

    attr_reader :model, :query, :filter_fields

    # New instance
    #
    # Params:
    #   - opts {Hash} with options
    #     - :model {Class} with a model
    #     - :query {String} to match each of :filter_fields
    #     - :filter_fields {Array} of fields
    #         to match :query against each
    def initialize(opts)
      @model         = opts[:model]
      @filter_fields = opts[:filter_fields]
      @query         = opts[:query]
    end

    def search_criteria
      criteria = []
      filter_fields.each{|key|
        criteria << {key => /#{query}/}
      }
      criteria
    end
  end
end
