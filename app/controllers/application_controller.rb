class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :upcoming_things

  private

  def after_sign_in_path_for(_)
    admin_dashboard_path
  end

  def upcoming_things
    @upcoming_things = Meetup.all
  end
end
