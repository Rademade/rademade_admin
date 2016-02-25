module Autocomplete
  class FilterSerializer < BaseSerializer

    protected

    def json_edit_url(item)
      admin_edit_uri(item)
    end

  end
end
