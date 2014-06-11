class RademadeAdmin::VideoService

  def initialize(file_path)
    @file_path = file_path
  end

  def take_random_screenshot(thumb_path)
    duration = duration_in_seconds
    screenshot_time = 1 + (duration.nil? ? 0 : Random.rand(duration - 1))
    `ffmpeg -ss #{screenshot_time} -i #{@file_path} -f image2 -vframes 1 #{thumb_path}`
  end

  def duration_in_seconds
    output = `ffmpeg -i #{@file_path} 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,//`
    if output =~ /([\d][\d]):([\d][\d]):([\d][\d]).([\d]+)/
      (($1.to_i * 60 + $2.to_i) * 60 + $3.to_i) + ($4.to_i / 100)
    else
      nil
    end
  end

end