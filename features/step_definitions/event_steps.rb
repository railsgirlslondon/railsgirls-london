Then /^I can see an event "(.*?)"$/ do |properties|
  find('.railsgify small').text.should have properties
end
