module RademadeAdmin
  module CrudController
    module Search
      class Searcher

        class << self

          def related_list?(params)
            !!(params[:parent])
          end

        end

        def get_list(params)
          self.class.related_list?(params) ? related_list(params) : list(params)
        end

        def list(params)
          init_filtering(params)

          model_items = @model.unscoped.where(@conditions.where)

          filter_items(model_items)
        end

        def related_list(params)
          init_filtering(params)

          model_items = parent_model.unscoped.find(parent_id).send(model_related_name)

          filter_items(model_items)
        end

        private

        def initialize(model_info)
          @model = model_info.model
          @origin_fields = model_info.origin_fields
        end

        def init_filtering(params)
          @params = params
          @conditions = SearchConditions.new(params, @origin_fields, paranoia_used?)
        end

        def filter_items(items)
          items #.order_by(@conditions.order)
            .page(@conditions.page)
            .per(@conditions.per_page)
        end

        def paranoia_used?
          defined?(Mongoid::Paranoia) and @model.ancestors.include? Mongoid::Paranoia
        end

        def parent_model
          @params[:parent].constantize
        end

        def parent_id
          @params[:parent_id]
        end

        def model_related_name
          @model.to_s.demodulize.pluralize.downcase.to_sym
        end

      end
    end
  end
end
