# Put shared click steps here.

# GIVEN
Given(/^I have clicked on "(.*?)"$/) do |text|
  within_page_content { click_on(text) }
end

Given(/^I have clicked on the "(.*?)" (button|link)$/) do |text, _type|
  step "I have clicked on \"#{text}\""
end

# WHEN
When(/^I click on the "(.*?)" (button|link)$/) do |text, type|
  step "I have clicked on the \"#{text}\" #{type}"
end

When(/^I click on the link in the email$/) do
  email = ActionMailer::Base.deliveries.last
  link = URI.extract(email.body.to_s).first
  visit(link)
end

When(/^I click on the "(.*?)" (button|link) in the "(.*?)" table's "(.*?)" row$/) do |action, _type, table_name, row_name|
  row = page.find(:css, 'table#' + table_name + '-table tbody tr', text: row_name)
  within(row) { click_on(action) }
end

When(/^I (accept|dismiss) the popup alert$/) do |action|
  page.driver.browser.switch_to.alert.send(action)
end
