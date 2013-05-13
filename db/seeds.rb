[{ name: 'London', description: '', slug: 'london' } ].each do |city|
  HostCity.create! name: city[:name], slug: city[:slug] rescue puts "#{city[:name]} already exists!"
end
