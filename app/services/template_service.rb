# -*- encoding : utf-8 -*-
module RademadeAdmin
  class TemplateService

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def template_path(*directories)
      "#{@root_dir}/#{directories.join('/')}"
    end

    def inner_layout
      layout_path 'inner'
    end

    def inner_form_layout
      layout_path 'inner/form'
    end

    def form_control_block
      block_path 'form_control'
    end

    def pagination_block
      block_path 'pagination'
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

    private

    def layout_path(layout)
      template_path '_layouts', layout
    end

    def block_path(block)
      template_path '_blocks', block
    end

  end
end