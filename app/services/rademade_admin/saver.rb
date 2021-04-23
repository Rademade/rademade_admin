# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Saver

    attr_accessor :item

    # Initialization of model saver class
    #
    # @param model_info [RademadeAdmin::Model::Info]
    # @param params [Hash]
    #
    def initialize(model_info, params)
      @model_info, @params = model_info, params
    end

    def create_model
      @item = @model_info.persistence_adapter.new_record
    end

    def find_model
      @item = @model_info.query_adapter.find(@params[:id])
    end

    def set_data
      save_galleries
      save_simple_fields
      save_localizable_fields
      save_item(validate: false) if @model_info.persistence_adapter.new?(item) # to init id
      save_model_uploads
      save_model_relations
      save_item
    end

    def save_item(options = {})
      @model_info.persistence_adapter.save(item, options)
    end

    private

    def save_simple_fields
      simple_field_params.each do |field, value|
        item.send(:"#{field}=", value)
      end
    end

    def save_localizable_fields
      current_locale = I18n.locale
      @model_info.data_items.localizable_fields.each do |_, data_item|
        values = @params[:data].try(:[], data_item.name)
        values.each do |locale, value|
          I18n.locale = locale
          if data_item.has_uploader?
            save_model_upload(data_item, value)
          else
            data_item.set_data(item, value)
          end
        end if values
      end
      I18n.locale = current_locale
    end

    def save_model_relations
      data = @params[:data]
      @model_info.data_items.related_fields.each do |_, data_item|
        if !data_item.gallery_relation? && data.has_key?(data_item.name)
          data_item.set_data(item, find_entities(data_item, data[data_item.name]))
        end
      end
    end

    def save_model_uploads
      data = @params[:data]
      @model_info.data_items.uploader_fields.each do |_, data_item|
        name = data_item.name
        save_model_upload(data_item, data[name]) if data.has_key?(name)
      end
    end

    def save_galleries
      data = @params[:data]
      @model_info.data_items.items.each do |_, data_item|
        if data_item.gallery_relation?
          name = data_item.name
          if data.has_key? name
            gallery_info = RademadeAdmin::Model::Graph.instance.model_info(data_item.relation.to)
            gallery = gallery_info.query_adapter.find(data[name].to_i)
            unless gallery
              gallery = gallery_info.persistence_adapter.new_record
              gallery_info.persistence_adapter.save(gallery)
              @item.send(:"#{name}_id=", gallery.id)
            end
            save_gallery_images(gallery_info, gallery, data["#{name}_images"])
          end
        end
      end
    end

    def save_gallery_images(gallery_info, gallery, images_data)
      return unless images_data
      gallery_image_data_item = gallery_info.data_items.data_item(:images)
      gallery_image_relation = gallery_image_data_item.relation
      gallery_image_info = RademadeAdmin::Model::Graph.instance.model_info(gallery_image_relation.to)
      saved_gallery_images = []
      images_data.each do |index, image_data|
        next unless image_data
        position = index.to_i + 1
        if image_data.has_key? :image_id
          gallery_image = gallery_image_info.query_adapter.find(image_data[:image_id])
          gallery_image.update(gallery_image_relation.sortable_field => position) if gallery_image_relation.sortable?
        else
          gallery_image = gallery_image_info.persistence_adapter.new_record
          gallery_image_info.persistence_adapter.save(gallery_image)
          if gallery_image_relation.sortable?
            gallery_image.public_send("#{gallery_image_relation.sortable_field}=", position)
          end
          gallery_image.image = ::RademadeAdmin::Base64Service.new.base64_to_file(image_data[:full_url])
          gallery_image.image.store!
          gallery_image_info.persistence_adapter.save(gallery_image)
        end
        saved_gallery_images << gallery_image
      end
      gallery_image_data_item.set_data(gallery, saved_gallery_images)
    end

    def save_model_upload(data_item, image_path)
      if item.try(:translation).respond_to? data_item.setter
        entity = item.translation
      else
        entity = item
      end
      if image_path.blank?
        item.instance_exec(&data_item.uploader.remove_proc)
      else
        if image_path.match /^http/ # is full path already
          item.instance_exec(&data_item.uploader.remote_url_setter_proc(image_path))
        else
          full_image_path = data_item.uploader.full_path_for(image_path)
          data_item.set_data(entity, File.open(full_image_path))
          item.public_send(data_item.getter)&.store!
        end
      end
    rescue
      # rm_todo clear image
    end

    def find_entities(data_item, ids)
      if ids.kind_of? Array
        ids = ids.map { |sub_ids| sub_ids.split(',') }.flatten.reject { |id| id.empty? }
        related_entities(data_item, ids)
      else
        ids.empty? ? nil : data_item.relation.related_entities(ids)
      end
    end

    def simple_field_params
      @params.require(:data).slice(*@model_info.data_items.save_form_fields)
    end

    def related_entities(data_item, ids)
      ids.map { |id| data_item.relation.related_entities(id) }
    end

  end
end
