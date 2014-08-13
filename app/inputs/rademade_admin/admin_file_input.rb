# -*- encoding : utf-8 -*-
module RademadeAdmin
  class AdminFileInput < SimpleForm::Inputs::Base

    #include UploadPreviewHelper
    #include UriHelper
    #
    #def to_html
    #  input_wrapping do
    #    template.content_tag(
    #      :div,
    #      HtmlBuffer.new([label_html, file_html]),
    #      {:class => 'uploader-block'}
    #    )
    #  end
    #end
    #
    #def file_html
    #  template.content_tag(
    #    :div,
    #    HtmlBuffer.new([preview_html, input_file_html, upload_progress_html, input_hidden_html]),
    #    {:class => 'uploader-wrapper'}
    #  )
    #end
    #
    #def preview_html
    #  file_preview_html(object.send(method))
    #end
    #
    #def input_file_html
    #  builder.file_field(method, {
    #    :id => nil,
    #    :class => 'uploader-input-file',
    #    :name => input_name,
    #    :data => {
    #      :column => input_name,
    #      :id => object.id.to_s,
    #      :saved => object.new_record? ? 0 : 1,
    #      :model => model_name,
    #      :uploader => uploader_classname,
    #      :url => admin_url_for(:controller => 'file', :action => 'upload')
    #    }
    #  })
    #end
    #
    #def input_hidden_html
    #  builder.hidden_field(method, {
    #    :class => 'uploader-input-hidden hidden'
    #  })
    #end
    #
    #def upload_progress_html
    #  progress_slider = template.content_tag(:div, '', {:class => 'upload-progress'})
    #  template.content_tag(:div, progress_slider, {
    #    :class => 'upload-progress-wrapper',
    #    :style => 'display:none;clear:both'
    #  })
    #end
    #
    #protected
    #
    #def current_file
    #  object.send(input_name)
    #end
    #
    #def uploader_classname
    #  current_file.class.name
    #end

  end
end
