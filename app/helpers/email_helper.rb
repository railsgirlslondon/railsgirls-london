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

  def email_sponsor_logo(event, sponsor_name)
    'sponsors/' + event.sponsors.find_by(name: sponsor_name).image_url
  end

  def slack_invite_url
    ENV['SLACK_INVITE']
  end
end
