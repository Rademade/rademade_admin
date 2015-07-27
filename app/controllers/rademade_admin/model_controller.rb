# -*- encoding : utf-8 -*-
# todo extract more modules
module RademadeAdmin
  class ModelController < RademadeAdmin::AbstractController

    extend RademadeAdmin::ModelOptions

    include RademadeAdmin::InstanceOptions
    include RademadeAdmin::Templates
    include RademadeAdmin::Notifier
    
    helper ::RademadeAdmin::FieldHelper
    helper ::RademadeAdmin::FormHelper
    helper ::RademadeAdmin::UriHelper

    before_filter :load_options, :additional_options, :pagination_variants
    before_filter :sortable_service, :only => [:index]

    def create
      authorize! :create, model_class
      saver = RademadeAdmin::Saver.new(model_info, params)
      saver.create_model
      saver.set_data
      before_create saver.item
      saver.save_item
      success_insert saver.item
    rescue Exception => e
      render_record_errors e
    end

    def update
      saver = RademadeAdmin::Saver.new(model_info, params)
      saver.find_model
      authorize! :update, saver.item
      saver.set_data
      before_update saver.item
      saver.save_item
      success_update saver.item
    rescue Exception => e
      render_record_errors e
    end

    def destroy
      @item = model.find(params[:id])
      authorize! :destroy, @item
      before_destroy @item
      @item.destroy if @item
      success_delete @item
    end

    def autocomplete
      authorize! :read, model_class
      render :json => Autocomplete::BaseSerializer.new(autocomplete_items)
    end

    def link_autocomplete
      authorize! :read, model_class
      relation_service = RademadeAdmin::RelationService.new
      @related_model_info = relation_service.related_model_info(model_info, params[:relation])
      render :json => Autocomplete::LinkSerializer.new(link_autocomplete_items, model.find(params[:id]), params[:relation])
    end

    def index
      authorize! :read, model_class
      list_breadcrumbs
      @items = index_items
      respond_to do |format|
        format.html { render_template }
        format.json { render :json => @items }
        format.csv { render_csv }
      end
    end

    def new
      authorize! :create, model_class
      @with_create_and_return_button = true
      @item = new_model
      new_breadcrumbs
      render_template
    end

    def edit
      @item = model.find(params[:id])
      authorize! :update, @item
      @with_create_and_return_button = true
      edit_breadcrumbs
      render_template
    end

    # TODO move related to other controller or remove
    def related
      authorize! :read, model_class
      @related_model_info = RademadeAdmin::RelationService.new.related_model_info(model_info, params[:relation])
      @item = model.find(params[:id])
      search_params = params.except(:id)
      @items = related_items(search_params)
      @sortable_service = RademadeAdmin::SortableService.new(@related_model_info, search_params)
      respond_to do |format|
        format.html {
          related_breadcrumbs
          render_template
        }
        format.json { render :json => Autocomplete::BaseSerializer.new(@items) }
      end
    end

    def related_add
      @item = model.find(params[:id])
      linker = Linker.new(model_info, @item, params[:relation])
      linker.link(params[:related_id])
      success_link
    end

    def related_destroy
      @item = model.find(params[:id])
      linker = Linker.new(model_info, @item, params[:relation])
      linker.unlink(params[:related_id])
      success_unlink
    end

    def show
      @item = model.find(params[:id])
      authorize! :read, @item
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.json { render :json => @item }
      end
    end

    def form
      authorize! :read, model_class
      @item = params[:id].blank? ? new_model : model.find(params[:id])
      render form_template_path(true), :layout => false
    end

    def sort
      sortable_service.sort_items
      success_action
    end

    protected
    # TODO move to search module

    def index_items
      conditions = Search::Conditions::List.new(params, model_info.data_items)
      Search::Searcher.new(model_info).search(conditions)
    end

    def autocomplete_items
      conditions = Search::Conditions::Autocomplete.new(params, model_info.data_items)
      Search::Searcher.new(model_info).search(conditions)
    end

    def link_autocomplete_items
      conditions = Search::Conditions::Autocomplete.new(params, @related_model_info.data_items)
      Search::Searcher.new(@related_model_info).search(conditions)
    end

    def related_items(search_params)
      conditions = Search::Conditions::RelatedList.new(@item, search_params, @related_model_info.data_items)
      Search::Searcher.new(@related_model_info).search(conditions)
    end

    def new_model
      model.new
    end

    def before_create(item)

    end

    def before_update(item)

    end

    def before_destroy(item)

    end

    def model
      @model ||= model_info.model
    end

    def render_template(template = action_name)
      render abstract_template(template)
    end

    def sortable_service
      @sortable_service ||= RademadeAdmin::SortableService.new(model_info, params)
    end

    def additional_options
      MenuCell.current_model = model
    end

    def render_record_errors(e)
      if e.respond_to? :record
        render_errors e.record.errors
      else
        render_errors e.message
      end
    end

    def render_csv
      send_data RademadeAdmin::CsvService.new(model_info, @items).to_csv
    end

    def pagination_variants
      @pagination_variants ||= [20, 40, 60]
    end
  end
end
