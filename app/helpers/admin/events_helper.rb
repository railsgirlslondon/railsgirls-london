module Admin::EventsHelper

  def default_to_coachable coachable
    coachable.coachable rescue true
  end
end
