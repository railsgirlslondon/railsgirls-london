module ControllerHelpers
  def sign_in(user = double('user'))
    if user.nil?
      request.env['warden'].stub(:authenticate!).
        and_throw(:warden, {scope: :user})
        allow(controller).to receive_messages(current_user:  nil)
    else
      request.env['warden'].stub :authenticate! => user
      allow(controller).to receive_messages(current_user:  user)
    end
  end
end
