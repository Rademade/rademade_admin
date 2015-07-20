# -*- encoding : utf-8 -*-
module RademadeAdmin
  class TemplateService

    attr_writer :main_layout, :login_layout, :layout_head, :menu_block

    # attr_accessor :index_template,
    #               :inner_layout,
    #               :main_layout,
    #               :inner_form_layout,
    #               :form_block,
    #               :form_control_block,
    #               :form_lang_panel_block,
    #               :form_separator_block,
    #               :pagination_block ,
    #               :on_page_select_block,
    #               :sort_reset_block,
    #               :search_block,
    #               :header_block,
    #               :menu_block,
    #               :sub_menu_block,
    #               :sub_menu_link_block,
    #               :table_head_block,
    #               :cancel_button

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

    # def index_template
    #   @index_template ||= abstract_template 'index'
    # end
    #
    # def inner_layout
    #   @inner_layout ||= layout_path 'inner'
    # end
    #
    # def main_layout
    #   @main_layout ||= layout_path 'main'
    # end
    #
    # def inner_form_layout
    #   @inner_form_layout ||= layout_path 'inner/form'
    # end
    #
    # def form_block
    #   @form_block ||= block_path 'form'
    # end
    #
    # def form_control_block
    #   @form_control_block ||= block_path 'form/control'
    # end
    #
    # def form_lang_panel_block
    #   @form_lang_panel_block ||= block_path 'form/lang_panel'
    # end
    #
    # def form_separator_block
    #   @form_separator_block ||= block_path 'form/separator'
    # end
    #
    # def pagination_block
    #   @pagination_block ||= block_path 'pagination'
    # end
    #
    # def on_page_select_block
    #   @on_page_select_block ||= block_path 'on_page_select'
    # end
    #
    # def sort_reset_block
    #   @sort_reset_block ||= block_path 'sort_reset'
    # end
    #
    # def search_block
    #   @search_block ||= block_path 'search'
    # end
    #
    # def header_block
    #   @header_block ||= block_path 'header'
    # end
    #
    # def menu_block
    #   @menu_block ||= block_path 'menu'
    # end
    #
    # def sub_menu_block
    #   @sub_menu_block ||= block_path 'sub_menu'
    # end
    #
    # def sub_menu_link_block
    #   @sub_menu_link_block ||= block_path 'sub_menu/link'
    # end
    #
    # def table_head_block
    #   @table_head_block ||= block_path 'table/head'
    # end
    #
    # def cancel_button
    #   @cancel_button ||= block_path 'button/cancel'
    # end

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
