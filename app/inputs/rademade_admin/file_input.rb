# -*- encoding : utf-8 -*-
module RademadeAdmin
  class FileInput < SimpleForm::Inputs::FileInput

    include UriHelper

    def input(wrapper_options = {})
      template.content_tag(
        :div,
        template.content_tag(:div, holder_html, :class => 'upload-box'),
        :class => 'upload-list'
      )
      # HtmlBuffer.new([file_html, download_button_html]),
    end

    private

    def holder_html
      template.content_tag(
        :div,
        template.content_tag(
          :div,
          RademadeAdmin::HtmlBuffer.new([
            input_file_html,
          ]),
          :class => 'upload-item add'
        ),
        :class => 'upload-holder'
      )
    end

    # def file_html
    #   template.content_tag(
    #     :div,
    #     HtmlBuffer.new([
    #       upload_preview_service.preview_html,
    #       input_file_html,
    #       upload_progress_html,
    #       upload_button_html,
    #       upload_preview_service.is_crop? ? crop_button_html : '',
    #       input_hidden_html
    #     ]),
    #     { :class => 'uploader-wrapper' }
    #   )
    # end

    def input_file_html
      @builder.file_field(uploader.mounted_as, {
        :id => nil,
        :name => uploader.mounted_as,
        :data => {
          :saved => object.new_record? ? 0 : 1,
          :url => rademade_admin_route(:file_upload_url)
        }.merge(uploader_params)
      })
    end

    def input_hidden_html
      @builder.hidden_field(attribute_name, {
        :class => 'uploader-input-hidden hidden',
        :value => uploader.url
      }.merge(input_html_options))
    end

    # def upload_progress_html
    #   progress_slider = template.content_tag(:div, '', { :class => 'upload-progress' })
    #   template.content_tag(:div, progress_slider, {
    #     :class => 'upload-progress-wrapper'
    #   })
    # end
    #
    # def upload_button_html
    #   template.content_tag(:span, I18n.t('rademade_admin.uploader.upload'), {
    #     :class => 'btn green-btn upload-btn',
    #     :data => {
    #       :upload => true
    #     }
    #   })
    # end
    #
    # def download_button_html
    #   template.content_tag(:a, I18n.t('rademade_admin.uploader.download'), {
    #     :class => 'btn blue-btn download-btn',
    #     :href => admin_url_for({
    #       :controller => 'rademade_admin/file',
    #       :action => 'download'
    #     }.merge(uploader_params)) #todo use route name and resources
    #   }) unless uploader.file.nil?
    # end
    #
    # def crop_button_html
    #   template.content_tag(:span, I18n.t('rademade_admin.uploader.crop'), {
    #     :class => 'btn red-btn upload-btn',
    #     :data => {
    #       :crop => true,
    #       :url => rademade_admin_route(:file_crop_url)
    #     }
    #   })
    # end

    def upload_preview_service
      @upload_preview_service ||= RademadeAdmin::Upload::PreviewService.new(uploader)
    end

    def uploader
      @uploader ||= input_html_options[:value] || object.send(attribute_name)
    end

    def photo_uploader?
      uploader.class.ancestors.include? RademadeAdmin::Uploader::Photo
    end

    def uploader_params
      {
        :id => object.id.to_s,
        :model => object.class.to_s,
        :uploader => uploader.class.to_s,
        :column => uploader.mounted_as
      }
    end

  end
end
