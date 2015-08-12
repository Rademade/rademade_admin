# -*- encoding : utf-8 -*-
module RademadeAdmin
  class LocationInput < SimpleForm::Inputs::Base

    def input(wrapper_options = {})
      template.content_tag(
        :div,
        HtmlBuffer.new([map_html, location_attributes_html]),
        { :class => 'location' }
      )
    end

    protected

    def map_html
      template.content_tag(:div, '', {
        :id => "map_#{object.id}",
        :class => 'map'
      })
    end

    def location_attributes_html
      location_attributes = object.send(attribute_name)
      HtmlBuffer.new([
        location_attribute_html(location_attributes, :latitude),
        location_attribute_html(location_attributes, :longitude),
        location_attribute_html(location_attributes, :zoom, 1)
      ])
    end

    def location_attribute_html(location_attributes, name, default_value = 0)
      template.content_tag(:input, '', {
        :type => 'hidden',
        :name => "data[#{attribute_name}][#{name}]",
        :value => location_attributes[name] || default_value,
        :data => {
          :location_attribute => name
        }
      })
    end

  end
end