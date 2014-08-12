# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Notifier

    def success_action
      render :json => {
        :message => 'ok'
      }
    end

    def success_insert(item)
      success_message(item, 'was inserted!', {
        :form_action => admin_update_uri(item)
      })
    end

    def success_update(item)
      success_message(item, 'data was updated!')
    end

    def success_delete(item)
      success_message(item, 'was deleted!')
    end

    def success_unlink
      #rm_todo Уже можно сделать через success_message
      render :json => {
        :message => 'Entity was unlinked!'
      }
    end

    def success_link
      #rm_todo Уже можно сделать через success_message
      render :json => {
        :message => 'Entity was linked!'
      }
    end

    def success_message(item, action_message, additional_data = {})
      render :json => {
        :data => item,
        :message => "#{item_name.capitalize} #{action_message}"
      }.merge(additional_data)
    end

  end
end
