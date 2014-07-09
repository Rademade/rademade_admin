module RademadeAdmin
  class Saver

    attr_reader :item

    def initialize(model_info, params)
      @model_info = model_info
      @params = params
    end

    def create_model
      @item = @model_info.model.new filter_data_params
    end

    def update_model
      @item = @model_info.model.find(@params[:id])
      item.update filter_data_params
    end

    def save_model
      item.save @params
    end

    def save_aggregated_data
      save_model_relations
      save_model_uploads
      item.save!
    end

    def errors
      item.errors
    end

    private

    def save_model_relations
      data = @params[:data]
      @model_info.model_reflection.relations.each do |name, rel|
        assoc_key = association_foreign_key(rel)
        if data.has_key? assoc_key
          ids = data[assoc_key]
          ids.reject! { |id| id.empty? } if ids.kind_of?(Array)
          item.send(assoc_key + '=', ids)
        end
      end
    end

    def save_model_uploads
      data = @params[:data]
      @model_info.model_reflection.uploaders.each do |name, _|
        if data.has_key?(name) and not data[name].blank?
          image_path = CarrierWave.root + data[name].to_s
          setter_method = (name.to_s + '=').to_sym
          begin
            item.send(setter_method, File.open(image_path))
          rescue
            #rm_todo clear image
          end
        end
      end
    end

    def association_foreign_key(rel)
      if rel.is_a? ActiveRecord::Reflection::AssociationReflection # todo
        assoc_key = rel.association_foreign_key
        if rel.collection?
          assoc_key += 's'
        end
      else
        assoc_key = rel.foreign_key
      end
      assoc_key
    end

    def filter_data_params
      @params.require(:data).permit(@model_info.save_form_fields)
    end

  end
end