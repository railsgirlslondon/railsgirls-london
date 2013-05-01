Then /^I can see "(.*?)" listed as a host city$/ do |city_name|
  all(".host-cities a").each { |node| node.text.should == city_name }
end

When /^I click on "(.*?)"$/ do |city|
  find('.host-cities a').click
end
