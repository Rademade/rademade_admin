# -*- encoding : utf-8 -*-
class RademadeAdmin::FileController < RademadeAdmin::AbstractController

  def upload
    param_key = params[:column].to_sym
    uploader.store!(params[param_key])
    upload_preview_service = RademadeAdmin::Upload::PreviewService.new(uploader)
    render :json => {
      :html => upload_preview_service.preview_html,
      :file => uploader
    }
  rescue CarrierWave::UploadError => e
    render :json => { :error => e.to_s }, :status => :unprocessable_entity
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
    render :json => { :error => e.to_s }, :status => :unprocessable_entity
  end

  private

  def uploader
    @uploader ||= RademadeAdmin::LoaderService.const_get(params[:uploader]).new(model, params[:column])
  end

  def model
    model_class = RademadeAdmin::LoaderService.const_get(params[:model])
    params[:saved].to_i.zero? ? model_class.new : model_class.find(params[:id])
  end

end
