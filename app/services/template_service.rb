# -*- encoding : utf-8 -*-
module RademadeAdmin
  class TemplateService

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def template_path(*directories)
      "#{@root_dir}/#{directories.join('/')}"
    end
    
    def index_template
      abstract_template 'index'
    end

    def inner_layout
      layout_path 'inner'
    end

    def inner_form_layout
      layout_path 'inner/form'
    end

    def form_block
      block_path 'form'
    end

    def form_control_block
      block_path 'form/control'
    end

    def form_lang_panel_block
      block_path 'form/lang_panel'
    end

    def form_separator_block
      block_path 'form/separator'
    end

    def pagination_block
      block_path 'pagination'
    end

    def on_page_select_block
      block_path 'on_page_select'
    end

    def sort_reset_block
      block_path 'sort_reset'
    end

    def search_block
      block_path 'search'
    end

    def header_block
      block_path 'header'
    end

    def menu_block
      block_path 'menu'
    end

    def sub_menu_block
      block_path 'sub_menu'
    end

    def sub_menu_link_block
      block_path 'sub_menu/link'
    end

    def table_head_block
      block_path 'table/head'
    end

    def cancel_button
      block_path 'button/cancel'
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