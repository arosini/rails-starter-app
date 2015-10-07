# Put steps related to Roles here

# THEN
Then(/^I should see search suggestions for only the following roles: "(.*?)"$/) do |roles|
  role_list = roles.split(/, | and /)
  Role.all.each do |role|
    expect_suggestion = role_list.include?(role.name)
    expect(page).send(expect_suggestion ? :to : :to_not, have_css('div.tt-suggestion > p', text: /\A#{role.name}\z/))
  end
end
