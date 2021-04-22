# frozen_string_literal: true

# https://gist.github.com/shrikanthkr/10097999
module RademadeAdmin
  class Base64Service

    def base64_to_file(image)
      Base64.decode64(image)
      if image
        image_parts = image.split(',')
        matches = /\/(.+);/.match(image_parts[0])
        extension = matches.nil? ? 'jpg' : matches[1]
        image = file_decode(image_parts[1], "photo.#{extension}")
      end
    rescue
      image
    end

    def file_decode(base, filename)
      file = Tempfile.new([file_base_name(filename), file_extension(filename)])
      file.binmode
      file.write(Base64.decode64(base))
      file.close
      file
    end

    def file_base_name(file_name)
      File.basename(file_name, file_extension(file_name))
    end

    def file_extension(file_name)
      File.extname(file_name)
    end

  end
end
