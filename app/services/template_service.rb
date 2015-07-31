# -*- encoding : utf-8 -*-
module RademadeAdmin
  class TemplateService

    attr_writer :main_layout, :login_layout, :content_item_layout, :layout_head, :menu_block, :search_block,
                :pagination_block, :on_page_switcher_block, :table_head_block, :table_head_list,
                :list_block, :form_block, :form_control_block, :form_lang_panel_block,
                :destroy_button, :edit_button, :hide_button, :preview_button, :gallery_button,
                :cancel_button, :save_and_return_button, :save_button

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def template_path(*directories)
      "#{@root_dir}/#{directories.join('/')}"
    end

    def main_layout
      @main_layout ||= layout_path 'main'
    end

    def login_layout
      @login_layout ||= layout_path 'login'
    end

    def content_item_layout
      @content_item_layout ||= layout_path 'content_item'
    end

    def layout_head
      @layout_head ||= layout_path 'parts/head'
    end

    def menu_block
      @menu_block ||= block_path 'menu'
    end

    def search_block
      @search_block ||= block_path 'search'
    end

    def pagination_block
      @pagination_block ||= block_path 'pagination'
    end

    def on_page_switcher_block
      @on_page_switcher_block ||= block_path 'on_page_switcher'
    end

    def table_head_block
      @table_head_block ||= block_path 'table/head'
    end

    def table_head_list
      @table_head_list ||= block_path 'table/list'
    end

    def list_block
      @list_block ||= block_path 'list'
    end

    def form_block
      @form_block ||= block_path 'form'
    end

    def form_control_block
      @form_control_block ||= block_path 'form/control'
    end

    def form_lang_panel_block
      @form_lang_panel_block ||= block_path 'form/lang_panel'
    end

    def destroy_button
      @destroy_button ||= block_path 'button/destroy'
    end

    def edit_button
      @edit_button ||= block_path 'button/edit'
    end

    def hide_button
      @hide_button ||= block_path 'button/hide'
    end

    def preview_button
      @preview_button ||= block_path 'button/preview'
    end

    def gallery_button
      @gallery_button ||= block_path 'button/gallery'
    end

    def cancel_button
      @cancel_button ||= block_path 'button/cancel'
    end

    def save_and_return_button
      @save_and_return_button ||= block_path 'button/save_and_return'
    end

    def save_button
      @save_button ||= block_path 'button/save'
    end

    private

    def abstract_template(path)
      template_path 'abstract', path
    end

    def layout_path(layout)
      template_path '_layouts', layout
    end

    def block_path(block)
      template_path '_blocks', block
    end

  end
end
