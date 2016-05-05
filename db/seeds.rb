city = City.create(name: "London")

Event.create(
  city_id: city.id,
  description: 'A First Workshop',
  starts_on: '2018-01-01',
  ends_on: '2018-01-02'
)
