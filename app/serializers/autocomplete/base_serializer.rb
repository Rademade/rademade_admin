##
# Class: AutocompleteSerializer
#
# Creates hash (ready for JSON serialization) with
# pairs of id => value to show in the autocomplete
# select UI.
#
# The output format of to_json is optimized for 'Select2'
# autocomplete UI.
#
# It would generate JSON of models :id and :text. Text is determined by
# #to_autocomplete method, or by #to_s.
module Autocomplete
  class BaseSerializer
    include RademadeAdmin::UriHelper

    def initialize(collection)
      @collection = collection
    end

    def as_json
      build_json
    end

    # args are left for backward compatibility
    # to Rails :json renderer
    def to_json(*args)
      as_json.to_json
    end

    protected

    def item_to_json(item)
      {
        :id => item.id.to_s,
        :text => (item.respond_to?(:to_autocomplete) ? item.to_autocomplete : item.to_s),
        :edit_url => admin_edit_form_uri(item)
      }
    end

    private

    def build_json
      @collection.map { |item| item_to_json(item) }
    end

  end
end