module EmailHelper

  def invites_to_be_sent_date event
    first_deadline = event.registration_deadline-1.month
    second_deadline = event.registration_deadline+1.day
    if Date.today >= first_deadline
      second_deadline.strftime("%-d %B %Y")
    else
      first_deadline.strftime("%-d %B  %Y")
    end
  end

  def image_url_for image, *args
    host = 'http://railsgirlslondon.s3.amazonaws.com'
    image_tag "#{host}/#{image}", *args
  end

  def full_url_for path
    "http://railsgirls.london/#{path}"
  end
end
