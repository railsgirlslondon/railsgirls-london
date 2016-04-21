module ControllerHelpers
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).
        and_throw(:warden, {:scope => :user})
      allow(controller).to receive_messages(:current_user =>  nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive_messages(:current_user =>  user)
    end
  end
end
