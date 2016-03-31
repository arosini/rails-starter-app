# Put shared click steps here.

# GIVEN
Given(/^I have clicked on "(.*?)"$/) do |text|
  within_page_content { click_on(text) }
end

Given(/^I have clicked on the "(.*?)" (button|link)$/) do |text, _type|
  step "I have clicked on \"#{text}\""
end

Given(/^I have (un)?checked the "(.*?)" checkbox$/) do |un, checkbox|
  page.send(un ? :uncheck : :check, checkbox.downcase.tr(' ', '-') + '-checkbox')
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

When(/^I select "(.*?)" in the "(.*?)" dropdown$/) do |options, label|
  options_to_select = options.split(/, | and /)
  dropdown = page.find(:css, '.input-group', text: label)
  dropdown.find(:css, '.dropdown-toggle').click
  dropdown.all(:css, 'li').each do |option|
    selected = option[:class].include?('active')
    should_select = options_to_select.include?(option.text)
    option.find('label').click if (!selected && should_select) || (selected && !should_select)
  end
  dropdown.find(:css, '.dropdown-toggle').click
end

When(/^I (un)?check the "(.*?)" checkbox$/) do |un, checkbox|
  step "I have #{un}checked the \"#{checkbox}\" checkbox"
end
