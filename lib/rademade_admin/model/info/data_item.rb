# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItem

        attr_accessor :name, :field, :relation, :label,
                      :form_position, :list_position
        attr_writer :is_uploader, :in_form, :in_list
        attr_reader :form_params

        #
        # @param name [Symbol]
        # @param field [RademadeAdmin::Model::Info::Field]
        # @param relation [RademadeAdmin::Model::Info::Relation]
        #
        # rm_todo. Добавить +1 компонент uploader. initialize(name, field, relation, uploader)
        #
        def initialize(name, field, relation)
          @name, @field, @relation = name, field, relation
          @in_list, @in_form, @is_uploader = false, false, false
        end

        def has_relation?
          not @relation.nil?
        end

        def label
          @label ||= _default_label
        end

        def getter
          @getter ||= has_relation? ? @relation.name : @field.name
        end

        def in_list?
          @in_list
        end

        def in_form?
          @in_form
        end

        def uploader?
          @is_uploader
        end

        def form_params=(params)
          unless params[:as].present?
            params[:as] = default_field_type
          end
          @form_params = params
        end

        private

        def _default_label
          name.to_s.humanize
        end

        # rm_todo эту задачу пускай решает helper. На низком уровне такая реализация лишняя
        def default_field_type
          if relation
             :'rademade_admin/admin_select'
          elsif uploader?
             :'rademade_admin/admin_file'
          else
             nil
          end
        end

      end
    end
  end
end