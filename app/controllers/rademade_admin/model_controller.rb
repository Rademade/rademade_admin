module RademadeAdmin
  class ModelController < RademadeAdmin::AbstractController

    extend RademadeAdmin::ModelConfiguration
    include RademadeAdmin::Linker
    include RademadeAdmin::InstanceOptions
    include RademadeAdmin::Templates
    include RademadeAdmin::Notifier

    before_filter :load_options

    def create
      authorize! :create, model_class
      saver = Saver.new(model_info, params)
      saver.create_model
      if saver.save_model
        saver.save_aggregated_data
        success_insert saver.item
      else
        render_errors saver.errors
      end
    end

    def update
      authorize! :update, model_class
      saver = Saver.new(model_info, params)
      if saver.update_model
        saver.save_aggregated_data
        success_update saver.item
      else
        render_errors saver.errors
      end
    end

    def destroy
      authorize! :destroy, model_class
      @item = find_item(params[:id])
      @item.delete if @item
      success_delete @item
    end

    def autocomplete
      authorize! :read, model_class
      search_conditions = Search::AutocompleteConditions.new(params, origin_fields, model_info.filter_fields)
      searcher = Search::Searcher.new model_info
      items = searcher.search search_conditions
      render :json => AutocompleteSerializer.new(items)
    end

    # todo another action for related
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
      success_unlink item
    end

    def link_relation
      item = find_item(params[:id])
      link(item)
      item.save
      success_link item
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

  end
end
