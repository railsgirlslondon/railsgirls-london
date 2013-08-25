module Admin::EventsHelper

  def default_to_coachable coachable
    coachable.coachable rescue true
  end

  def event_title event
    title = event.city_name
    title << " - #{event.title}" unless event.title.blank?
    title
  end
end
