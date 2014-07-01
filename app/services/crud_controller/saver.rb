module RademadeAdmin
  module CrudController
    module Saver

      def save_aggregated_data(item, params)
        save_model_relations(item, params[:data])
        save_model_uploads(item, params[:data])
        item.save!
      end

      def save_model_relations(item, data)
        model_reflection.relations.each do |name, rel|

          key_suffix = rel.many? ? '_ids' : '_id'
          assoc_key = (name.singularize + key_suffix).to_sym

          if data.has_key?(assoc_key)
            relation_class = LoaderService.const_get(rel.class_name)

            ids = data[assoc_key]
            ids.reject! { |id| id.empty? } if ids.kind_of?(Array)

            entities = relation_class.find(ids)

            # advanced magic
            # for sorting items by id in same order
            # as ids elements order
            entities.sort_by! { |entity| ids.index(entity.id.to_s) } if entities.kind_of? Enumerable

            entities = nil if (!rel.many? && entities == [])
            item.send(rel.setter, entities)
          end
        end
      end

      def save_model_uploads(item, data)
        model_reflection.uploaders.each do |name, _|
          if data.has_key?(name) and !data[name].blank?
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

    end
  end
end