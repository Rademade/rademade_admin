# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Notifier

    # TODO use responder (respond with)

    def success_action
      render :json => {
        :message => I18n.t('rademade_admin.success_message.simple')
      }
    end

    def success_insert(item)
      respond_to do |format|
        format.html { redirect_to admin_edit_uri(item) }
        format.json { success_message(item, I18n.t('rademade_admin.success_message.insert'), success_data(item)) }
      end
    end

    def success_update(item)
      respond_to do |format|
        format.html { redirect_to admin_edit_uri(item) }
        format.json { success_message(item, I18n.t('rademade_admin.success_message.update'), success_data(item)) }
      end
    end

    def success_delete(item)
      respond_to do |format|
        format.html { redirect_to admin_list_uri(item) }
        format.json { success_message(item, I18n.t('rademade_admin.success_message.delete')) }
      end
    end
    
    def success_status_change(item)
      respond_to do |format|
        format.html { redirect_to admin_list_uri(item) }
        format.json { success_message(item, t('rademade_admin.success_message.status_update')) }
      end
    end

    def success_unlink
      render :json => {
        :message => I18n.t('rademade_admin.success_message.unlink')
      }
    end

    def success_link
      render :json => {
        :message => I18n.t('rademade_admin.success_message.link')
      }
    end

    def success_message(item, message, additional_data = {})
      render :json => {
        :data => Autocomplete::BaseSerializer.new([item]).as_json.first,
        :message => message
      }.merge(additional_data)
    end

    def success_data(item)
      data = {}
      if params.has_key?(:save_and_return)
        data[:with_return] = true
      else
        data[:form_action] = admin_update_uri(item) # TODO check JS. Rename for update
      end
      data
    end

  end
end