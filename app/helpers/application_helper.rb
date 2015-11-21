module ApplicationHelper

  def landing_page_anchor_link(anchor)
    params[:controller] == "home" ?  "##{anchor}" : "#{root_path}##{anchor}"
  end

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

  def page_title
    title = "Rails Girls London"
    title << " -  #{@event.title}" if @event and @event.active
    title
  end

  def city_twitter
    "railsgirls_ldn"
  end

  def city_facebook
    "railsgirlslondon"
  end

  def path_active?(path)
    "active" if current_page?(path)
  end

  def gravatar_url(email,size=50)
    "http://gravatar.com/avatar/#{md5(email)}?s=#{size}&d=https://raw.githubusercontent.com/railsgirlslondon/railsgirls-london/master/app/assets/images/avatar50px.jpg"
  end

  def md5(string)
    Digest::MD5.hexdigest(string.strip.downcase)
  end

  def twitter_widget_id
    railsgirls_twitter_widget_id
  end

  private

  def railsgirls_twitter_widget_id
    "380105070089490433"
  end
end
