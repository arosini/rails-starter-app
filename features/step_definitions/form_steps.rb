# Put shared steps for interacting with forms and their components here.

# GIVEN
Given(/^I have entered "(.*?)" in the "(.*?)" field$/) do |value, field_name|
  fill_in field_name.downcase.tr(' ', '-') + '-field', with: value
end

Given(/^I have filled out the "(.*?)" form with the following values:$/) do |form_name, table|
  within(:css, 'form#' + form_name.downcase.tr(' ', '_')) do
    table.hashes.each do |row|
      step "I have entered \"#{row[:value]}\" in the \"#{row[:field]}\" field"
    end
  end
end

# WHEN
When(/^I enter "(.*?)" in the "(.*?)" field$/) do |value, field_name|
  step "I have entered \"#{value}\" in the \"#{field_name}\" field"
end

When(/^I fill out the "(.*?)" form with the following values:$/) do |form_name, table|
  step "I have filled out the \"#{form_name}\" form with the following values:", table
end

When(/^I search with the following values:$/) do |table|
  table.hashes.each do |row|
    step "I have entered \"#{row[:value]}\" in the \"#{row[:field] + '-cont-search'}\" field"
  end
end

When(/^I select "(.*?)" in the "(.*?)" dropdown$/) do |options, dropdown|
  options_to_select = options.split(/, | and /)
  dropdown = page.first(:css, '.input-group', text: dropdown)
  dropdown.find(:css, '.dropdown-toggle').click
  dropdown.all(:css, 'li').each do |option|
    selected = option[:class].include?('active')
    should_select = options_to_select.include?(option.text)
    option.find('label').click if (!selected && should_select) || (selected && !should_select)
  end
end

# THEN
Then(/^I should( not)? see an error message saying "(.*?)" near the "(.*?)" field$/) do |negate, msg, field_name|
  error_field = page.find('#' + field_name.downcase.tr(' ', '-') + '-field-errors') rescue ''
  expect(error_field).send(negate ? :to_not : :to, have_content(msg))
end

Then(/^I should( not)? see an error message saying "(.*?)"$/) do |negate, msg|
  error_field = page.find('p.alert-danger') rescue ''
  expect(error_field).send(negate ? :to_not : :to, have_content(msg))
end
