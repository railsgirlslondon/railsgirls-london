class KipptConfig
  attr_accessor :host, :token, :username

  def headers
    {
      "X-Kippt-Username" => username,
      "X-Kippt-API-Token" => token
    }
  end

  def configured?
    token.present? && username.present? && host.present?
  end
end
