Given /^I navigate to "(.*?)"$/ do |path|
  visit path
end

Given /^I can view "(.*?)"$/ do |information|
  page.should have_content information
end

