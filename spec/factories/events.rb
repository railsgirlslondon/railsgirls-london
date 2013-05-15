FactoryGirl.define do
  factory :event do
    start_date    { Date.new(2013,04,19) }
    end_date      { Date.new(2013,04,20) }
  end
end
