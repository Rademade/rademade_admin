# -*- encoding : utf-8 -*-
class RademadeAdmin::FileController < RademadeAdmin::AbstractController

  def upload
    param_key = params[:column].to_sym
    uploader.store!(params[param_key])
    render :json => {
      :html => RademadeAdmin::Upload::PreviewService.new(uploader).preview_html,
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
    image = uploader.crop_image(params[:path], params[:crop])
    uploader.store!(image)
    upload_preview_service = RademadeAdmin::Upload::PreviewService.new(uploader)
    render :json => {
      :html => upload_preview_service.preview_html,
      :file => uploader
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
    params[:id].nil? ? model_class.new : model_class.find(params[:id])
  end

end