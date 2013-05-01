[{ name: 'London', description: '', slug: 'london' },
 { name: 'Bath', desription: '', slug: 'bath' }].each do |city|
  HostCity.create! name: city[:name], slug: city[:slug] rescue puts "#{city[:name]} already exists!"
end
