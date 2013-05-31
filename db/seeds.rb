if Rails.env.development? || Rails.env.test?
  City.destroy_all
  Event.destroy_all
end

city = City.create name: 'London', twitter: 'railsgirls_ldn'

event = Event.create description: "Rails Girls comes to London 19-20 April 2013. Join us for the two-day crash course in the exciting world of building web applications with Ruby on Rails.",
  starts_on: Date.new(2013,4,19),
  ends_on: Date.new(2013,4,20),
  city_id: city.id,
  active: false

event.sponsors = Sponsor.create([{
  name: 'New Bamboo',
  image_url: 'http://railsgirls.com/images/london/new_bamboo_logo.png',
  description: 'New Bamboo is a specialist in agile development using Ruby, Rails and HTML5.',
  website: 'http://new-bamboo.co.uk/'
}, {
  name: 'Made by Many',
  description: 'Made by Many helps clients design innovative products and services for a social and networked world.',
  image_url: 'http://railsgirls.com/images/london/made_by_many_logo.png',
  website: 'http://madebymany.com/'
},{
  name: 'HouseTrip', description: 'Ranked the number two start-up in Europe (2012) by Wired Magazine, it’s one of Europe’s largest holiday rental booking websites.',
  image_url: 'http://railsgirls.com/images/london/housetrip_logo.jpg',
  website: 'http://housetrip.com/'}
])
event.save!
