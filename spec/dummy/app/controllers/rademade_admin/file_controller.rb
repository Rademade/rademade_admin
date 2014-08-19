#todo extract like service

class RademadeAdmin::FileController < RademadeAdmin::AbstractController

  include RademadeAdmin::UploadPreviewHelper #todo via :helper include

  def upload
    begin
      param_key = params[:column].to_sym
      uploader.store!(params[param_key])
      render :json => {
        :html => preview_html,
        :file => uploader
      }
    rescue CarrierWave::UploadError => e
      render :json => {:error => e.to_s}, :status => :unprocessable_entity
    end
  end

  def uploader
    @uploader ||= RademadeAdmin::LoaderService.const_get(params[:uploader]).new(model, params[:column])
  end

  def model
    model_class = RademadeAdmin::LoaderService.const_get(params[:model])
    params[:saved].to_i.zero? ? model_class.new : model_class.find(params[:id])
  end

end
