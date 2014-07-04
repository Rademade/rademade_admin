module RademadeAdmin
  class ModelController < RademadeAdmin::AbstractController

    include RademadeAdmin::CrudController

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
      items = RademadeAdmin::AutocompleteService.new(
        :model => model_class,
        :filter_fields => model_info.filter_fields,
        :query => params[:q]
      ).search
      items = items.where(build_search_params(params[:search]))
      render :json => AutocompleteSerializer.new(items)
    end

    def index
      authorize! :read, model_class

      @searcher ||= Searcher.new(model_info)

      @items = @searcher.get_list(params) # calls 'list' or 'related_list' public method
      @sortable_service = RademadeAdmin::SortableService.new(model_info, params)

      respond_to do |format|
        format.html { Searcher.related_list?(params) ? render_template('related_index') : render_template }
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

    # todo: notify module/service (move to module)
    def success_action
      render :json => {
        :message => 'ok'
      }
    end

    def success_insert(item)
      render :json => {
        :data => item,
        :message => item_name.capitalize + ' was inserted!',
        :form_action => admin_update_uri(item)
      }
    end

    def success_update(item)
      success_message(item, 'data was updated!')
    end

    def success_delete(item)
      success_message(item, 'was deleted!')
    end

    def success_unlink(item)
      success_message(item, 'was unlinked from entity!')
    end

    def success_link(item)
      success_message(item, 'was linked to entity!')
    end

    def success_message(item, action_message)
      render :json => {
        :data => item,
        :message => "#{item_name.capitalize} #{action_message}"
      }
    end

    def find_item(id)
      model_info.model.find(id)
    end

    def render_template(template = action_name)
      #todo if template doesn't exist in user application => render abstract template (form or view)
      render "rademade_admin/abstract/#{template}"
      #unless template_exists?(template, "admin/#{native_template_folder}")
    end

  end
end
