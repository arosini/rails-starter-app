# Put shared 'Then' steps here

# Content
Then(/^I should( not)? see "(.*?)" on the page$/) do |negate, content|
  expect(page).send(negate ? :to_not : :to, have_content(content))
end

Then(/^I should( not)? see the page title as "(.*?)"$/) do |negate, title|
  expect(page).send(negate ? :to_not : :to, have_selector('.page-title', text: title))
end

Then(/^I should( not)? see an alert message saying "(.*?)"$/) do |negate, msg|
  expect(page).send(negate ? :to_not : :to, have_selector('.alert', text: msg))
end

# Buttons / Links
Then(/^I should( not)? see a(n)? "(.*?)" (button|link)$/) do |negate, _n, text, _type|
  expect(page).send(negate ? :to_not : :to, have_selector(:link_or_button, text))
end

Then(/^I should( not)? see the following buttons: "(.*?)"$/) do |negate, buttons|
  button_list = buttons.split(/, | and /)
  button_list.each do |button|
    within_page_content { step "I should#{negate} see a \"#{button}\" button" }
  end
end

Then(/^I should( not)? see a link to "(.*?)" that says "(.*?)"$/) do |negate, link_path, link_text|
  within_page_content do
    link = find('a', text: link_text, visible: true) rescue nil
    negate ? expect(link).to(be_nil) : expect(URI.parse(link['href']).path).to(eq(link_path))
  end
end

# Navigation
Then(/^the current path should( not)? be "(.*?)"$/) do |negate, path|
  expect(current_path).send(negate ? :to_not : :to, eq(path))
end

Then(/^I should( not)? see the "(.*?)" page$/) do |negate, page_name_or_path|
  step "the current path should#{negate} be \"#{pathify(page_name_or_path)}\""
end

Then(/^I should( not)? be redirected to the "(.*?)" page$/) do |negate, page_name|
  step "the current path should#{negate} be \"#{pathify(page_name)}\""
end

Then(/^I should( not)? be able to navigate to the "(.*?)" page$/) do |negate, page_name|
  step "I have navigated to the \"#{page_name}\" page"
  step "I should#{negate} see the \"#{page_name}\" page"
  if negate
    msg = 'You are not authorized to view that page.'
    if @current_user.nil?
      msg = 'You need to sign in or sign up before continuing.'
    end
    step "I should see an error message saying \"#{msg}\"" if @current_user
  end
end

# Tables 
Then(/^I should( not)? see "(.*?)" in the "(.*?)" table's "(.*?)" row$/) do |negate, row_text, table_name, row_name|
  row = page.find(:css, 'table#' + table_name + '-table tbody:nth-child(n+1)', text: row_name)
  expect(row).send(negate ? :to_not : :to, have_content(row_text))
end

Then(/^I should( not)? see a "(.*?)" row in the "(.*?)" table$/) do |negate, row_name, table_name|
  table = page.find(:css, 'table#' + table_name + '-table')
  expect(table).send(negate ? :to_not : :to, have_selector('tbody:nth-child(n+1)', text: row_name))
end

Then(/^I should( not)? see the following actions in the "(.*?)" table's "(.*?)" row: "(.*?)"$/) do |negate, table_name, row_name, actions|
  row = page.find(:css, 'table#' + table_name + '-table tbody:nth-child(n+1)', text: row_name)
  actions.split(/, | and /).each do |action|
    expect(row).send(negate ? :to_not : :to, have_selector(:link_or_button, action))
  end
end

# Fields
Then(/^I should( not)? see a(n)? "(.*?)" field$/) do |negate, _n, field|
  expect(page).send(negate ? :to_not : :to, have_field(field))
end

# Then(/^I should( not)? see the "(.*?)" field prepopulated with a value of "(.*?)"$/) do |negate, field, value|
#   expect(page).send(negate ? :to_not : :to, have_field(field, with: value))
# end
