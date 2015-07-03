class Member < ActiveRecord::Base
  REQUIRED_ATTRIBUTES = [ :first_name,
                          :last_name,
                          :email,
                          :city ]


  PERMITTED_ATTRIBUTES = [ *REQUIRED_ATTRIBUTES, :city_id, :phone_number, :twitter ]
  ALL_ATTRIBUTES = [*PERMITTED_ATTRIBUTES, :active]

  validates(*REQUIRED_ATTRIBUTES, presence: true)
  validates :email, uniqueness: { scope: :city_id }

  attr_accessible(*ALL_ATTRIBUTES)

  belongs_to :city

  scope :latest, -> { order('members.created_at DESC').limit(10) }

  has_one :registration

  before_create do
    self.uuid = SecureRandom.uuid
  end

  def self.deactivate!(uuid)
    find_by(uuid: uuid).tap do |member|
      member.active = false
      member.save!
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.create_from_registration registration
    member = Member.create(permitted_attributes_from(registration))
    registration.update_attributes(member: member) if member.save
    member
  end

  def self.permitted_attributes_from registration
    attributes = registration.attributes.select { |k, v| PERMITTED_ATTRIBUTES.include? k.to_sym }
    attributes.merge! city_id: registration.event.city_id
  end
end
