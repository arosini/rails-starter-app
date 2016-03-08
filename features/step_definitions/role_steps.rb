# Put steps related to Roles here

# THEN
Then(/^I should( not)? be redirected to the "(.*?)" role page$/) do |negate, role_name|
  step "the current path should#{negate} be \"/roles/#{Role.where(name: role_name).first.id}\""
end

Then(/^I should see search results for only the following roles: "(.*?)"$/) do |roles|
  name_list = roles.split(/, | and /)
  Role.all.each do |role|
    expect_role = name_list.include?(role.name)
    step "I should#{expect_role ? '' : ' not'} see a row for \"#{role.name}\" in the \"roles\" table"
  end
end

Then(/^I should see search suggestions for only the following roles: "(.*?)"$/) do |roles|
  name_list = roles.split(/, | and /)
  Role.all.each do |role|
    expect_suggestion = name_list.include?(role.name)
    expect(page).send(expect_suggestion ? :to : :to_not, have_css('div.tt-suggestion > p', text: /\A#{role.name}\z/))
  end
end

Then(/^I should( not)? see the edit page for the "(.*?)" role$/) do |negate, role_name|
  role_id = Role.find_by(name: role_name).id
  step "the current path should#{negate} be \"#{edit_role_path(role_id)}\""
  step "I should#{negate} see the page title as \"Edit Role #{role_id}\""
end

Then(/^I should( not)? see the "(.*?)" role page$/) do |negate, role_name|
  role_id = Role.find_by(name: role_name).id
  step "the current path should#{negate} be \"#{role_path(role_id)}\""
  step "I should#{negate} see the page title as \"Role #{role_id}\""
end

Then(/^I should( not)? be able to navigate to the "(.*?)" role page$/) do |negate, role_name|
  step "I should#{negate} be able to navigate to the \"/roles/#{Role.where(name: role_name).first.id}\" page"
end