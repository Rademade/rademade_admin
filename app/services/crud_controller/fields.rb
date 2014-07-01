module RademadeAdmin
  module CrudController
    module Fields

      UNSAVED_FIELD = [:_id, :created_at, :deleted_at, :position]

      attr_accessor :fields,
                    :simple_fields,
                    :fields_data,
                    :form_fields

      attr_writer :list_fields,
                  :additional_form_fields,
                  :filter_fields

      def origin_fields
        fields.map(&:to_s) + ['id']
      end

      def association_fields
        model_class.relations.keys.map &:to_sym
      end

      def uploader_fields
        model_class.respond_to?(:uploaders) ? @uploader_fields = model_class.uploaders.keys : []
      end

      def list_fields
        @list_fields ||= simple_fields
      end

      def default_form_fields
        simple_fields + association_fields
      end

      def save_form_fields
        @save_form_fields ||= semantic_form_fields.keys + additional_form_fields
      end

      def additional_form_fields
        @additional_form_fields ||= []
      end

      def semantic_form_fields
        @semantic_form_fields ||= collected_form_fields
      end

      def filter_fields
        @filter_fields ||= load_filter_fields
      end

      def load_filter_fields
        list_fields.select{ |field|
          @fields_data.has_key?(field) and @fields_data[field].type == String
        }
      end

      def init_model_fields
        #rm_todo load only once
        @fields = []
        @fields_data = {}
        @simple_fields = []

        model_class.fields.each do |name, field|
          @fields << field_name = name.to_sym
          @fields_data[ field_name ] = field

          #!a && !b => !(a || b)
          unless (UNSAVED_FIELD.include?(field_name) || field.foreign_key?)
            @simple_fields << field_name
          end
        end
      end

      private
      def collected_form_fields
        data = (@form_fields || default_form_fields)

        fields = {}

        data.each do |field|
          if field.is_a?(Hash)
            fields.merge! field
          else
            fields[field] = default_field_type field
          end
        end
        fields
      end

      def default_field_type(field)
        if association_fields.include? field
          :'rademade_admin/admin_select'
        elsif uploader_fields.include? field
          :'rademade_admin/admin_file'
        else
          nil
        end
      end

    end
  end
end
