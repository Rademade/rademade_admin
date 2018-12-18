# -*- encoding : utf-8 -*-
class RademadeAdmin::GalleryController < RademadeAdmin::ApplicationController

  def upload
    render :json => {
      :gallery_images_html => gallery_service.upload_images(params[:gallery_id], params[:files])
    }
  rescue Exception => e
    show_error(e)
  end

  def crop
    uploader = gallery_service.crop_image(params[:id], params[:crop])
    preview_service = RademadeAdmin::Upload::Preview::GalleryPreview.new
    render :json => {
      :image_data => preview_service.image_data(uploader),
      :resized_url => preview_service.gallery_image_preview(uploader)
    }
  rescue Exception => e
    show_error(e)
  end

  def remove
    gallery_service.remove_image(params[:id])
    render :json => { }
  rescue Exception => e
    show_error(e)
  end

  def sort
    gallery_service.sort_images(params[:images])
    render :json => { }
  rescue Exception => e
    show_error(e)
  end

  private

  def show_error(error)
    render :json => { :error => error.to_s }, :status => :unprocessable_entity
  end

  def gallery_service
    @gallery_service ||= RademadeAdmin::Gallery::Manager.new(params[:class_name])
  end

end
