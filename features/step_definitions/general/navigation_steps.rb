# Put shared navigation steps here.

# GIVEN
Given(/^I have navigated to the "(.*?)" page$/) do |page_name|
  visit(pathify(page_name))
end

# WHEN
When(/^I navigate to the "(.*?)" page$/) do |page_name|
  step "I have navigated to the \"#{page_name}\" page"
end
