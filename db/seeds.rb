[{ name: 'London', description: '', slug: 'london', twitter: '@railsgirls_ldn' } ].each do |city|
  HostCity.create! name: city[:name], slug: city[:slug] rescue puts "#{city[:name]} already exists!"
end
