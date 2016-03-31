# Put shared steps for interacting with forms and their components here.

# GIVEN
Given(/^I have entered "(.*?)" in the "(.*?)" field$/) do |value, field|
  fill_in field, with: value
end

Given(/^I have filled out the "(.*?)" form with the following values:$/) do |form, table|
  within(:css, 'form#' + form.downcase.tr(' ', '_')) do
    table.hashes.each do |row|
      step "I have entered \"#{row[:value]}\" in the \"#{row[:field]}\" field"
    end
  end
end

# WHEN
When(/^I enter "(.*?)" in the "(.*?)" field$/) do |value, field|
  step "I have entered \"#{value}\" in the \"#{field}\" field"
end

When(/^I fill out the "(.*?)" form with the following values:$/) do |form, table|
  step "I have filled out the \"#{form}\" form with the following values:", table
end

When(/^I enter "(.*?)" in the "(.*?)" (contains|equals|less than or equals|greater than or equals) search field$/) do |value, field, type|
  type = case type
         when 'contains' then 'cont'
         when 'equals' then 'eq'
         when 'less than or equals' then 'lteq'
         when 'greater than or equals' then 'gteq'
         end
  search_field_id = field.downcase.tr(' ', '-') + '-' + type + '-search-field'
  fill_in search_field_id, with: value
end

# THEN
Then(/^I should( not)? see an error message that says "(.*?)" near the "(.*?)" field$/) do |negate, text, field|
  error_field = find_field(field).first(:xpath, '../following-sibling::div')
  expect(error_field).send(negate ? :to_not : :to, have_content(text))
end

Then(/^I should( not)? see an error message that says "(.*?)"$/) do |negate, text|
  expect(page).send(negate ? :to_not : :to, have_selector('p.alert-danger', text: text))
end
