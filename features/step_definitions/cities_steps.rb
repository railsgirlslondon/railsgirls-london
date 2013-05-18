Given(/^I have a city called "(.*?)"$/) do |cityname|
  City.create(:name => cityname)
end

When(/^I click on "(.*?)"$/) do |cityname|
  click_on(cityname)
end

Given /^I navigate to "(.*?)"$/ do |path|
  visit path
end

Given /^I can view "(.*?)"$/ do |information|
  page.should have_content information
end

