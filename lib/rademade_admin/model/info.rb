module RademadeAdmin
  module Model
    class Info

      UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position] # todo

      attr_reader :model_reflection

      def initialize(model_reflection, model_configuration)
        @model_reflection = model_reflection
        @model_configuration = model_configuration
        @initialized = false
      end

      def origin_fields
        @model_reflection.fields.map(&:to_s) + ['id']
      end

      def uploader_fields
        @model_reflection.uploader_fields
      end

      def list_fields
        @list_fields ||= @model_configuration[:list_fields] || simple_fields
      end

      def default_form_fields
        simple_fields + @model_reflection.association_fields
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

      def method_missing(name, *arguments)
        if arguments.empty? and @model_configuration[name].present?
          @model_configuration[name]
        elsif @model_reflection.respond_to? name
          @model_reflection.send(name, *arguments)
        end
      end

      private

      def simple_fields
        init_model_fields
        @simple_fields
      end

      def init_model_fields
        #rm_todo load only once
        unless @initialized
          #@fields = []
          @fields_data = {}
          @simple_fields = []
          @model_reflection.fields.each do |name, field|
            #@fields << field_name = name.to_sym
            field_name = name.to_sym
            @fields_data[field_name] = field
            #!a && !b => !(a || b)
            unless (UNSAVED_FIELDS.include?(field_name) || foreign_key?(field, field_name))
              @simple_fields << field_name
            end
          end
          @initialized = true
        end
      end

      def load_filter_fields
        init_model_fields
        list_fields.select do |field|
          @fields_data.has_key?(field) and @fields_data[field].type == String
        end
      end

      def collected_form_fields
        data = (@model_configuration[:form_fields] || default_form_fields)
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
        if @model_reflection.association_fields.include? field
          :'rademade_admin/admin_select'
        elsif @model_reflection.uploader_fields.include? field
          :'rademade_admin/admin_file'
        else
          nil
        end
      end

      private

      def foreign_key?(field, field_name)
        field.respond_to?(:foreign_key?) ? field.foreign_key? : field_name[-3, 3] == '_id' # todo for active record
      end

    end
  end
end