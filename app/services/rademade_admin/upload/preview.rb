# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Upload
    class Preview

      include ActionView::Helpers::TagHelper
      include ActionView::Context
      include UriHelper

      def image_data(uploader)
        {
          image_id: uploader.model.id.to_s,
          full_url: uploader.url || '',
          name: uploader.file.try(:filename)
        }
      end

    end
  end
end
