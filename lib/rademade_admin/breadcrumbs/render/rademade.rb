class Breadcrumbs::Render::Rademade < Breadcrumbs::Render::Base

  def render
    items = breadcrumbs.items
    size = items.size

    html = items.each_with_index.map do |item, index|
      render_item(item, index == size - 1)
    end

    tag(:div, RademadeAdmin::HtmlBuffer.new([html]), :class => 'breadcrumbs')
  end

  def render_item(item, is_last)
    text, url, options = *item
    link_class = is_last ? 'is-active' : 'is-highlight'
    html = []
    html << tag(:a, text, :href => url, :class => link_class)
    tag(:div, '', :class => 'content-header')
  end

end