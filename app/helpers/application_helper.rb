module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def link_to_kippt link
    link_to "kippt", "http://kippt.com#{link}"
  end

  def city_name
    @city ? @city.name : "UK"
  end

  def page_title
    title = "Rails Girls #{city_name}"
    title << " -  #{@event.title}" if @event and @event.active
    title
  end

  def city_twitter
    @city ? @city.twitter : "railsgirls"
  end

  def city_slug
    @city ? @city.slug : ""
  end

  def path_active?(path)
    "active" if current_page?(path)
  end

end
