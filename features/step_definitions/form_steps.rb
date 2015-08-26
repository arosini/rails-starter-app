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

When(/^I search with the following values:$/) do |table|
  table.hashes.each do |row|
    step "I have entered \"#{row[:value]}\" in the \"#{row[:field]}\" field"
  end
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
end

# THEN
Then(/^I should( not)? see an error message saying "(.*?)" near the "(.*?)" field$/) do |negate, text, field|
  error_field = find_field(field).first(:xpath, '../following-sibling::div')
  expect(error_field).send(negate ? :to_not : :to, have_content(text))
end

Then(/^I should( not)? see an error message saying "(.*?)"$/) do |negate, text|
  error_field = page.find('p.alert-danger') rescue ''
  expect(error_field).send(negate ? :to_not : :to, have_content(text))
end
