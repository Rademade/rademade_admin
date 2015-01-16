# -*- encoding : utf-8 -*-
module RademadeAdmin
  class StatusController < RademadeAdmin::AbstractController

    include RademadeAdmin::Notifier

    def toggle
      authorize! :update, params[:model]
      status_changer = RademadeAdmin::Status::Toggler.new(params[:model], params[:id])
      status_changer.init_item
      status_changer.toggle
      success_status_change(status_changer.item)
    end

  end
end