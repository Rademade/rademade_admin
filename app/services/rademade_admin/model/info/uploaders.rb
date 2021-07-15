# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Uploaders

        def initialize(data_adapter)
          @data_adapter = data_adapter
        end

        def all
          @data_adapter.uploaders
        end

        def uploader(name)
          @data_adapter.uploader(name)
        end

        def has_uploader?(name)
          !!(@data_adapter.uploader(name) || has_localized_uploader?(name))
        end

        private

        def has_localized_uploader?(name) # todo mb make "send" and check return type
          I18n.available_locales.each do |locale|
            return true unless @data_adapter.uploader("#{name}_#{locale}").nil?
          end
          false
        end

      end
    end
  end
end