module MessageManager
   extend ActiveSupport::Concern

  def render_error partial='new', message
    flash[:error] = message
    render partial
  end
end

