Then /^I can see an event "(.*?)"$/ do |properties|
  find('.railsgify').text.should have properties
end
