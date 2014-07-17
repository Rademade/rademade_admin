# -*- encoding : utf-8 -*-
module RademadeAdmin
  class ModelController < RademadeAdmin::AbstractController

    extend RademadeAdmin::ModelOptions
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
        @item = saver.item
        success_insert @item
      else
        render_errors saver.errors
      end
    end

    def update
      authorize! :update, model_class
      saver = Saver.new(model_info, params)
      if saver.update_model
        saver.save_aggregated_data
        @item = saver.item
        success_update @item
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
      init_search Search::Conditions::Autocomplete.new(params, origin_fields, model_info.filter_fields)
      render :json => Autocomplete::BaseSerializer.new(@items)
    end

    def link_autocomplete
      authorize! :read, model_class
      init_search Search::Conditions::Autocomplete.new(params, origin_fields, model_info.filter_fields)
      render :json => Autocomplete::LinkSerializer.new(@items, params[:parent], params[:parent_id])
    end

    def index
      authorize! :read, model_class
      init_search Search::Conditions::List.new(params, origin_fields)
      init_sortable_service
      respond_to do |format|
        format.html { render_template }
        format.json { render :json => @items }
      end
    end

    def related_index
      authorize! :read, model_class
      init_search Search::Conditions::RelatedList.new(params, origin_fields)
      init_sortable_service
      @parent_model_info = RademadeAdmin::Model::Graph.instance.model_info(params[:parent])
      @parent = @parent_model_info.model.find(params[:parent_id])
      respond_to do |format|
        format.html { render_template }
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

    def link_relation
      process_link :link
    end

    def unlink_relation
      process_link :unlink
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
      init_sortable_service
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

    def init_search(search_conditions)
      @searcher = Search::Searcher.new model_info
      @items = @searcher.search search_conditions
    end

    def init_sortable_service
      @sortable_service = RademadeAdmin::SortableService.new(model_info, params)
    end

    def process_link(method)
      linker = Linker.new(model_info, params[:parent], params[:parent_id])
      linker.send(method, params[:id])
      send("success_#{method}", find_item(params[:id]))
    end

  end
end
