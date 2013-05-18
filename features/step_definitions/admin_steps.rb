Given(/^an admin exists$/) do
  User.create!(email: "admin@railsgirls.co.uk", password: "admin12345")
end

Given(/^I log in as that admin$/) do
  visit new_user_session_path

  fill_in "Email", with: "admin@railsgirls.co.uk"
  fill_in "Password", with: "admin12345"
  click_on "Sign in"
end

When(/^I create a city$/) do
  expect(page).to_not have_content("London")

  click_link "New city"

  fill_in "Name", with: "London"
  click_on "Create City"
end

Then(/^it shows up on the city list$/) do
  expect(page).to have_content "London"

  visit root_path
  expect(page).to have_content("London")
end