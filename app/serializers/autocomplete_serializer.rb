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
class AutocompleteSerializer
  include RademadeAdmin::UriHelper

  def as_json
    build_json
  end

  # args are left for backward compatibility
  # to Rails :json renderer
  def to_json(*args)
    as_json.to_json
  end

  private

  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def build_json
    items = []
    collection.each do |member|
      items << {
        :id => member.id.to_s,
        :text => (member.respond_to?(:to_autocomplete) ? member.to_autocomplete : member.to_s),
        :edit_url => admin_edit_form_uri(member)
      }
    end
    items
  end

end
