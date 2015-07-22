class Breadcrumbs::Render::Rademade < Breadcrumbs::Render::Base

  def render
    html = breadcrumbs.items.each_with_index.map do |item, index|
      render_item(item, index)
    end
    RademadeAdmin::HtmlBuffer.new([html])
  end

  def render_item(item, index)
    text, url, options = *item
    html = []
    class_name = 'content-header-link'
    if last?(index)
      html << tag(:span, text, :class => "#{class_name} is-active")
      html << ico_html(index) unless index.zero?
    else
      html << tag(:a, text, :href => url, :class => "#{class_name} is-highlight")
    end
    tag(:div, RademadeAdmin::HtmlBuffer.new([html]), :class => 'content-header')
  end

  private

  def ico_html(index)
    tag(:a, '', :class => 'close-link', :href => breadcrumbs.items[index - 1][1])
  end

  def last?(index)
    index == breadcrumbs.items.size - 1
  end

end