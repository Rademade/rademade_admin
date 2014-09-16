module CarrierWave
  module Mongoid

    alias_method :original_mount_uploader, :mount_uploader

    def mount_uploader(column, uploader = nil, options = {}, &block)
      if options[:localize]

        field options[:mount_on] || column, :localize => true

        I18n.available_locales.each do |locale|
          original_mount_uploader("#{column}_#{locale}", uploader, options, &block)
        end

        # todo if it is ok - make also remove method
        class_eval <<-RUBY, __FILE__, __LINE__+1

          def #{column}=(new_file)
            send(:"#{column}_\#{I18n.locale}=", new_file)
          end

          def #{column}
            send(:"#{column}_\#{I18n.locale}")
          end

          def #{column}_translations=(translations)
            translations.each do |locale, translation|
              send("#{column}_\#{locale}=", translation)
            end
          end

          def #{column}_translations
            translations = {}
            I18n.available_locales.each do |locale|
              translations[locale] = send("#{column}_\#{locale}")
            end
            translations
          end

        RUBY

      else
        original_mount_uploader(column, uploader, options, &block)
      end
    end

  end
end