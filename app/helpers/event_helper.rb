module EventHelper

  def render_event_partial
    render partial: "#{@event.city.slug}#{@event.id}" rescue ""
  end

end
