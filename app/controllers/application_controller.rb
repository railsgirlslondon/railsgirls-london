class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :upcoming_meetups
  after_action :set_csrf_token_header

  private

  def set_csrf_token_header
    response.headers['X-Csrf-Token'] = form_authenticity_token
  end

  def after_sign_in_path_for(_)
    admin_dashboard_path
  end

  def upcoming_meetups
    @upcoming_meetups = Meetup.upcoming
  end
end
