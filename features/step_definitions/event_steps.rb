Then /^I can see the latest event date "(.*?)"$/ do |properties|
  find('.railsgify small').text.should.eql? properties
end
