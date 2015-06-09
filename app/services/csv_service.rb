# -*- encoding : utf-8 -*-
require 'csv'

module RademadeAdmin
  class CsvService

    def initialize(model_info, items)
      @model_info = model_info
      @items = items
    end

    def to_csv
      ::CSV.generate(col_sep: ',', encoding: 'utf-8') do |csv|
        csv << column_names
        @items.each do |item|
          csv << item_data(item)
        end
      end
    end

    def column_names
      @model_info.data_items.csv_fields.map(&:label)
    end

    def item_data(item)
      data = []
      @model_info.data_items.csv_fields.each do |field|
        data << field_value(field, item)
      end
      data
    end

    def field_value(field, item)
      return field.csv_preview_handler.call(item) unless field.csv_preview_handler.nil?
      item.send(field.csv_preview_accessor).to_s
    end
  end
end
