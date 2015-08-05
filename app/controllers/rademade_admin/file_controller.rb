# -*- encoding : utf-8 -*-
class RademadeAdmin::FileController < RademadeAdmin::AbstractController

  def upload
    param_key = params[:column].to_sym
    uploader.store!(params[param_key])
    render :json => {
      :html => RademadeAdmin::Upload::Preview::File.new(uploader).preview_html,
      :file => uploader
    }
  rescue CarrierWave::UploadError => e
    show_error(e)
  end

  def download
    # todo filename
    send_file(uploader.model.send(uploader.mounted_as).file.file)
  end

  def crop
    image = uploader.crop_image(params[:crop], params[:path])
    uploader.store!(image)
    preview_service = RademadeAdmin::Upload::Preview::File.new(uploader)
    render :json => {
      :image_data => preview_service.image_data(uploader),
      :resized_url => preview_service.image_preview
    }
  rescue CarrierWave::UploadError => e
    show_error(e)
  end

  private

  def show_error(error)
    render :json => { :error => error.to_s }, :status => :unprocessable_entity
  end

  def uploader
    @uploader ||= RademadeAdmin::LoaderService.const_get(params[:uploader]).new(model, params[:column])
  end

  def model
    model_class = RademadeAdmin::LoaderService.const_get(params[:model])
    model_object = nil
    if params[:id].present?
      model_object = model_class.find(params[:id]) rescue nil
    end
    model_object || model_class.new
  end

end