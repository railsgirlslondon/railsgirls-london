class ErrorsController < ApplicationController
  def not_found
    render :not_found, :layout => 'error', :status => :not_found
  end
end
