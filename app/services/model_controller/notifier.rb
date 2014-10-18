# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Notifier

    def success_action
      render :json => {
        :message => 'ok'
      }
    end

    def success_insert(item)
      respond_to do |format|
        format.html { redirect_to admin_edit_uri(item) }
        format.json {
          success_message(item, 'was inserted!', {
            :form_action => admin_update_uri(item)
          })
        }
      end
    end

    def success_update(item)
      respond_to do |format|
        format.html { redirect_to admin_edit_uri(item) }
        format.json {
          success_message(item, 'data was updated!')
        }
      end
    end

    def success_delete(item)
      respond_to do |format|
        format.html { redirect_to admin_list_uri(item) }
        format.json {
          success_message(item, 'was deleted!')
        }
      end
    end

    def success_unlink
      render :json => {
        :message => 'Entity was unlinked!'
      }
    end

    def success_link
      render :json => {
        :message => 'Entity was linked!'
      }
    end

    def success_message(item, action_message, additional_data = {})
      render :json => {
        :data => Autocomplete::BaseSerializer.new([item]).as_json.first,
        :message => "#{model_info.singular_name.capitalize} #{action_message}"
      }.merge(additional_data)
    end

  end
end
