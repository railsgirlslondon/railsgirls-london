module EmailHelper

  def image_url_for image, *args
    image_tag "#{@host}/assets/#{image}", *args
  end

  def full_url_for path
    "http://railsgirls.london/#{path}"
  end
end
