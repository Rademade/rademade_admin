module DownloadCsv

  def index_for_csv(data)
    authorize! :read, model_class
    list_breadcrumbs
    @items = index_items
    respond_to do |format|
      format.html { render_template }
      format.json { render json: @items }
      format.csv do
        send_data csv_responder(data, collation)
      end
    end
  end

  protected

  def csv_responder(data)
    data.to_csv
  end
end
