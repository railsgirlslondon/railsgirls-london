FactoryGirl.define do
  factory :host_city do
    name      "London"
    events    { [create(:event)] }
    slug      "london"
  end
end
