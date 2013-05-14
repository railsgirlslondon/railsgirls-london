city = HostCity.create! name: 'London', description: '', slug: 'london', twitter: '@railsgirls_ldn'
city.events << Event.create!(start_date: Date.new(2013,04,19), end_date: Date.new(2013,04,20))
