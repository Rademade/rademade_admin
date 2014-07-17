# -*- encoding : utf-8 -*-
#todo move to concern dir
module RademadeAdmin
  class HtmlBuffer < Array

    def html_safe
      join( $/ ).html_safe
    end

    def to_s
      html_safe
    end

  end
end
