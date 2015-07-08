# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Saver

    attr_reader :item

    # Initialization of model saver class
    #
    # @param model_info [RademadeAdmin::Model::Info]
    # @param params [Hash]
    #
    def initialize(model_info, params)
      @model_info, @params = model_info, params
    end

    def create_model
      @item = @model_info.model.new
    end

    def find_model
      @item = @model_info.model.find(@params[:id])
    end

    def set_data
      item.assign_attributes simple_field_params
      save_localizable_fields
      save_model_relations
      save_model_uploads
    end

    def save_item
      item.save!
    end

    private

    def save_localizable_fields
      current_locale = I18n.locale
      @model_info.data_items.localizable_fields.each do |_, data_item|
        values = @params[:data].try(:[], data_item.getter)
        values.each do |locale, value|
          I18n.locale = locale
          if data_item.has_uploader?
            save_model_upload(data_item, value)
          else
            item.send(data_item.setter, value)
          end
        end if values
      end
      I18n.locale = current_locale
    end

	  def save_model_relations
      data = @params[:data]
      @model_info.data_items.related_fields.each do |_, data_item|
        if data.has_key? data_item.getter
          item.send(data_item.setter, find_entities(data_item, data[data_item.getter]))
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

    def save_model_upload(data_item, image_path)
      unless image_path.blank?
        full_image_path = "#{CarrierWave.root}#{image_path}"
        begin
          if item.try(:translation).respond_to? data_item.setter
            entity = item.translation
          else
            entity = item
          end
          entity.send(data_item.setter, File.open(full_image_path))
        rescue
          # rm_todo clear image
        end
      end
    end

    def find_entities(data_item, ids)
      if ids.kind_of? Array
        ids.reject! { |id| id.empty? }
        related_entities(data_item, ids)
      else
        ids.empty? ? nil : data_item.relation.related_entities(ids)
      end
    end

    def simple_field_params
      @params.require(:data).symbolize_keys.slice(*@model_info.data_items.save_form_fields)
    end

    def related_entities(data_item, ids)
      ids.map { |id| data_item.relation.related_entities(id) }
    end

  end
end
