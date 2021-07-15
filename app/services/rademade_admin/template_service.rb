# -*- encoding : utf-8 -*-
module RademadeAdmin
  class TemplateService

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def template_path(*directories)
      "#{@root_dir}/#{directories.join('/')}"
    end

    def method_missing(name, *arguments)
      setter = /(?<name>.*)=/.match(name)
      if setter
        template_paths[setter[:name].to_sym] = arguments[0]
      else
        template_paths[name]
      end
    end

    private

    def template_paths
      @template_paths ||= {
        :main_layout => layout_path('main'),
        :login_layout => layout_path('login'),
        :content_item_layout => layout_path('content_item'),
        :layout_head => layout_path('parts/head'),
        :navigation_block => block_path('navigation'),
        :navigation_menu_block => block_path('navigation/menu'),
        :navigation_menu_item_block => block_path('navigation/menu/item'),
        :search_block => block_path('search'),
        :pagination_block => block_path('pagination'),
        :on_page_switcher_block => block_path('on_page_switcher'),
        :table_head_block => block_path('table/head'),
        :table_head_list => block_path('table/list'),
        :list_block => block_path('list'),
        :form_block => block_path('form'),
        :form_control_block => block_path('form/control'),
        :form_lang_panel_block => block_path('form/lang_panel'),
        :destroy_button => block_path('button/destroy'),
        :edit_button => block_path('button/edit'),
        :hide_button => block_path('button/hide'),
        :preview_button => block_path('button/preview'),
        :gallery_button => block_path('button/gallery'),
        :cancel_button => block_path('button/cancel'),
        :save_and_return_button => block_path('button/save_and_return'),
        :save_button => block_path('button/save')
      }
    end

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