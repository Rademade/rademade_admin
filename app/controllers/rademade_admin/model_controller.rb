module RademadeAdmin
  class ModelController < RademadeAdmin::AbstractController

    include RademadeAdmin::CrudController
    include RademadeAdmin::Templates
    include RademadeAdmin::Notifier

    def create
      authorize! :create, model_class
      @item = model_info.model.new(filter_data_params(params))

      if @item.save
        save_aggregated_data(@item, params)
        success_insert(@item)
      else
        render_errors @item.errors
      end
    end

    def update
      authorize! :update, model_class
      @item = find_item(params[:id])
      if @item.update(filter_data_params(params))
        save_aggregated_data(@item, params)
        success_update(@item)
      else
        render_errors @item.errors
      end
    end

    def destroy
      authorize! :destroy, model_class
      @item = find_item(params[:id])
      @item.delete if @item
      success_delete(@item)
    end

    def autocomplete
      authorize! :read, model_class

      search_conditions = Search::AutocompleteConditions.new(params, origin_fields, model_info.filter_fields)
      searcher = Search::Searcher.new model_info
      items = searcher.search search_conditions

      render :json => AutocompleteSerializer.new(items)
    end

    def index
      authorize! :read, model_class

      is_related_list = !!params[:parent]

      search_conditions = Search::ListConditions.new(params, origin_fields)
      @searcher = Search::Searcher.new model_info
      @items = @searcher.search search_conditions, is_related_list

      @sortable_service = RademadeAdmin::SortableService.new(model_info, params)

      respond_to do |format|
        format.html { is_related_list ? render_template('related_index') : render_template }
        format.json { render :json => @items }
      end
    end

    def new
      authorize! :create, model_class
      @item = model_info.model.new
      render_template
    end

    def edit
      authorize! :update, model_class
      @item = find_item(params[:id])
      render_template
    end

    def unlink_relation
      item = find_item(params[:id])
      unlink(item)
      item.save
      success_unlink(item)
    end

    def link_relation
      item = find_item(params[:id])
      link(item)
      item.save
      success_link(item)
    end

    def show
      authorize! :read, model_class
      @item = find_item(params[:id])
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.json { render :json => @item }
      end
    end

    def form
      authorize! :read, model_class
      @item = params[:id].blank? ? model_info.model.new : find_item(params[:id])
      render form_template_path(true), :layout => false
    end

    def re_sort
      @sortable_service = RademadeAdmin::SortableService.new(model_info, params)
      @sortable_service.re_sort_items
      success_action
    end

    protected

    def find_item(id)
      model_info.model.find(id)
    end

    def render_template(template = action_name)
      render abstract_template(template)
    end

    def filter_data_params(params)
      params.require(:data).permit(save_form_fields)
    end

  end
end
