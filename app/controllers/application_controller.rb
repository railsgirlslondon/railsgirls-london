class ApplicationController < ActionController::Base
  protect_from_forgery

  private


  def after_sign_in_path_for(resource_or_scope)
    admin_cities_path
  end
end
