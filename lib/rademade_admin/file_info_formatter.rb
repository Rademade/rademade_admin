module RademadeAdmin
  class FileInfoFormatter

    def self.format_size(size)
      units = %w(B KB MB GB TB)
      digit_groups = (Math.log10(size) / Math.log10(1024)).to_i
      formatted_value = size.to_f / (1024 ** digit_groups)
      '%.2f' % formatted_value + ' ' + units[digit_groups]
    end

  end
end