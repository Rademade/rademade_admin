# -*- encoding : utf-8 -*-
module RademadeAdmin
  class TemplateService

    attr_writer :main_layout, :login_layout, :layout_head, :menu_block, :search_block,
                :pagination_block, :on_page_switcher_block

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
