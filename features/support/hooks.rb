Before '@cities' do
  city = HostCity.create! name: "London", slug: "london"
  city.events << Event.create(:start_date => Date.new(2014,11,01),
                              :end_date => Date.new(2014,11,12))
  city.save!
end
