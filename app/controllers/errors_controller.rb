class ErrorsController < ApplicationController
  def not_found
    render :not_found, :layout => 'error'
  end
end
