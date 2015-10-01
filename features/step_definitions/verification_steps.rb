# Put shared 'Then' steps here

Then(/^I should( not)? see "(.*?)" on the page$/) do |negate, content|
  expect(page).send(negate ? :to_not : :to, have_content(content))
end

Then(/^I should( not)? see a(n)? "(.*?)" (button|link)$/) do |negate, _n, text, _type|
  expect(page).send(negate ? :to_not : :to, have_selector(:link_or_button, text))
end

Then(/^I should( not)? see the following buttons: "(.*?)"$/) do |negate, buttons|
  button_list = buttons.split(/, | and /)
  button_list.each do |button|
    within_page_content { step "I should#{negate} see a \"#{button}\" button" }
  end
end

Then(/^the current path should( not)? be "(.*?)"$/) do |negate, path|
  expect(current_path).send(negate ? :to_not : :to, eq(path))
end

Then(/^I should( not)? see the page title as "(.*?)"$/) do |negate, expected_title|
  title = find('.page-title') rescue nil
  expect(title).send(negate ? :to_not : :to, have_content(expected_title))
end

Then(/^I should( not)? see an alert message saying "(.*?)"$/) do |negate, msg|
  msg_text = find('.alert').text
  expect(msg_text).send(negate ? :to_not : :to, include(msg))
end

Then(/^I should( not)? see a link to "(.*?)" that says "(.*?)"$/) do |negate, link_path, link_text|
  within_page_content do
    link = find('a', text: link_text, visible: true) rescue nil
    negate ? expect(link).to(be_nil) : expect(URI.parse(link['href']).path).to(eq(link_path))
  end
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

Then(/^I should( not)? see "(.*?)" in the "(.*?)" row$/) do |negate, value, row|
  cell = page.find(:css, 'td', text: row).find(:xpath, '..').find(:css, 'td', text: value)
  expect(cell).send(negate ? :to : :to_not, be_nil)
end

Then(/^I should see( not)? a row for "(.*?)" in the "(.*?)" table$/) do |negate, row, table|
  cell = page.find(:css, 'table#' + table + '-table td', text: row)
  expect(cell).send(negate ? :to : :to_not, be_nil)
end

Then(/^I should( not)? see a(n)? "(.*?)" field$/) do |negate, _n, field|
  expect(page).send(negate ? :to_not : :to, have_field(field))
end
