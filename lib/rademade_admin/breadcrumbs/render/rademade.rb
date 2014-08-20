class Breadcrumbs::Render::Rademade < Breadcrumbs::Render::Base

  def render
    html = []
    items = breadcrumbs.items
    size = items.size

    items.each_with_index do |item, i|
      html << render_item(item, i, size)
    end

    separator = tag(:span, '', :class => 'breadcrumbs-sep')

    tag(:div, html.join(" #{separator} "), :class => 'breadcrumbs')
  end

  def render_item(item, i, size)
    text, url, options = *item
    options[:class] ||= 'breadcrumbs-link'

    if i == size - 1
      options[:class] += ' current'
      options[:tag] = 'span'
    end

    options[:class].gsub!(/^ *(.*?)$/, '\\1')

    wrap_item(url, CGI.escapeHTML(text), options)
  end

end