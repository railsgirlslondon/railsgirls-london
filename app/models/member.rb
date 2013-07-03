class Member < ActiveRecord::Base
  REQUIRED_ATTRIBUTES = [ :given_names,
                          :last_name,
                          :phone_number,
                          :email,
                          :city_id ]

  validates *REQUIRED_ATTRIBUTES, :presence => true

  attr_accessible *REQUIRED_ATTRIBUTES, :twitter, :city

  belongs_to :city

  scope :latest, -> { order('members.created_at DESC').limit(10) }

  def name
    "#{given_names} #{last_name}"
  end
end
