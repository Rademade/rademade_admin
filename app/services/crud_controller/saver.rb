module RademadeAdmin
  module CrudController
    module Saver

      def save_aggregated_data(item, params)
        save_model_relations(item, params[:data])
        save_model_uploads(item, params[:data])
        item.save!
      end

      def save_model_relations(item, data)
        model_class.relations.each do |name, rel|

          key_suffix = rel.many? ? '_ids' : '_id'
          assoc_key = (name.singularize + key_suffix).to_sym

          if data.has_key?(assoc_key)
            relation_class = LoaderService.const_get( rel.class_name )

            ids = data[assoc_key]
            ids.reject!{ |id| id.empty? } if ids.kind_of?(Array)

            value = relation_class.find(ids)

            # advanced magic
            # for sorting items by id in same order
            # as ids elements order
            value.sort_by! { |item| ids.index(item.id.to_s) } if value.kind_of? Enumerable

            value = nil if (!rel.many? && value == [])
            item.send(rel.setter, value)
          end
        end
      end

      def save_model_uploads(item, data)
        if model_class.respond_to? :uploaders
          model_class.uploaders.each do |name, _|
            if data.has_key?(name) and !data[name].blank?
              image_path = CarrierWave.root + data[name].to_s
              setter_method = (name.to_s + '=').to_sym
              begin
                item.send( setter_method, File.open( image_path ))
              rescue
                #rm_todo clear image
              end
            end
          end
        end
      end

    end
  end
end