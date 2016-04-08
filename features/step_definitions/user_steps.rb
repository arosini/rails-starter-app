# Put steps that would mainly be used for manipulating/verifying user data here.

# GIVEN
Given(/^I have signed in as "(.*?)"$/) do |email|
  step 'I have navigated to the "Sign In" page' if current_path != sign_in_path
  step "I have entered \"#{email}\" in the \"Email\" field"
  step 'I have entered "asdqwe" in the "Password" field'
  step 'I have clicked on the "Sign In" button'
  @current_user = User.find_by(email: email) if current_path != sign_in_path
end

Given(/^I have signed in as "(.*?)" and told the application to remember me$/) do |email|
  step 'I have navigated to the "Sign In" page'
  step "I have entered \"#{email}\" in the \"Email\" field"
  step 'I have entered "asdqwe" in the "Password" field'
  step 'I have checked the "Remember Me" checkbox'
  step 'I have clicked on the "Sign In" button'
  @current_user = User.find_by(email: email) unless current_path == sign_in_path
end

Given(/^I have signed in as "(.*?)" using "(.*?)" as the password$/) do |email, password|
  step 'I have navigated to the "Sign In" page'
  step "I have entered \"#{email}\" in the \"Email\" field"
  step "I have entered \"#{password}\" in the \"Password\" field"
  step 'I have clicked on the "Sign In" button'
  @current_user = User.find_by(email: email) unless current_path == sign_in_path
end

Given(/^I have not signed in$/) do
  visit('/sign_out')
  @current_user = nil
end

Given(/^I have navigated to the profile page for "(.*?)"$/) do |email|
  user_id = User.find_by(email: email).id
  visit(user_path(user_id))
end

Given(/^I have navigated to the edit user page for "(.*?)"$/) do |email|
  user_id = User.find_by(email: email).id
  visit(edit_user_path(user_id))
end

# WHEN
When(/^I sign in as "(.*?)"$/) do |email|
  step "I have signed in as \"#{email}\""
end

When(/^I (try to )?sign in as "(.*?)" using "(.*?)" as the password$/) do |_try, email, password|
  step "I have signed in as \"#{email}\" using \"#{password}\" as the password"
end

When(/^I sign up with email "(.*?)", password "(.*?)" and password confirmation "(.*?)"$/) do |email, password, confirmation|
  step 'I have navigated to the "Sign Up" page'
  step "I have entered \"#{email}\" in the \"Email\" field"
  step "I have entered \"#{password}\" in the \"Password\" field"
  step "I have entered \"#{confirmation}\" in the \"Confirm\" field"
  step 'I have clicked on the "Sign Up" button'
  @current_user = User.find_by(email: email) unless current_path == sign_up_path
end

When(/^I navigate to the profile page for "(.*?)"$/) do |email|
  step "I have navigated to the profile page for \"#{email}\""
end

When(/^I navigate to the edit user page for "(.*?)"$/) do |email|
  step "I have navigated to the edit user page for \"#{email}\""
end

When(/^I sign out$/) do
  step 'I have not signed in'
end

When(/^I (try to )?change "(.*?)"'s password to "(.*?)" using password confirmation "(.*?)"$/) do |_try, email, password, confirmation|
  step "I submit the Forgot Your Password form using email \"#{email}\""
  step 'I should be redirected to the "Sign In" page'
  step 'I should see a success alert message that says "You will receive an email with instructions on how to change your password in a few minutes."'
  step "an email with a password change link should be sent to \"#{email}\""
  step 'I click on the link in the email'
  step "I enter \"#{password}\" in the \"Password\" field"
  step "I enter \"#{confirmation}\" in the \"Confirm\" field"
  step 'I click on the "Submit" button'
  @current_user = User.find_by(email: email) unless current_path == edit_user_password_path
end

When(/^I submit the Forgot Your Password form using email "(.*?)"$/) do |email|
  step 'I navigate to the "Forgot Your Password" page'
  step "I enter \"#{email}\" in the \"Email\" field"
  step 'I click on the "Submit" button'
end

When(/^I delete my account$/) do
  step 'I have navigated to the "My Profile" page'
  step 'I click on the "Delete" button'
  step 'I accept the popup alert'
  @current_user = nil
end

When(/^I delete "(.*?)"'s account$/) do |email|
  step "I have navigated to the profile page for \"#{email}\""
  step 'I click on the "Delete" button'
  step 'I accept the popup alert'
  @current_user = nil if @current_user.email == email
end

# THEN
Then(/^I should( not)? be automatically signed in$/) do |negate|
  step "I should#{negate} see the \"home\" page"
  expect(@current_user).send(negate ? :to : :to_not, be_nil)
end

Then(/^I should( not)? be automatically signed out$/) do |negate|
  step "I should#{negate} see the \"landing\" page"
  expect(@current_user).send(negate ? :to_not : :to, be_nil)
end

Then(/^I should( not)? be able to sign in as "(.*?)"$/) do |negate, email|
  step 'I have not signed in'
  step "I have signed in as \"#{email}\""
  step "I should#{negate} see a success alert message that says \"Signed in successfully.\""
end

Then(/^I should( not)? be able to sign in as "(.*?)" using "(.*?)" as the password$/) do |negate, email, password|
  step 'I have not signed in'
  step "I have signed in as \"#{email}\" using \"#{password}\" as the password"
  step "I should#{negate} see a success alert message that says \"Signed in successfully.\""
end

Then(/^I should( not)? see the profile page for "(.*?)"$/) do |negate, email|
  user = User.find_by(email: email)
  same_user = user == @current_user
  path = same_user ? my_profile_path : user_path(user)
  profile_page_title =
    same_user ? I18n.t('users.show.self_title') : I18n.t('users.show.other_title', user_id: user.id)
  step "the current path should#{negate} be \"#{path}\""
  step "I should#{negate} see the page title as \"#{profile_page_title}\""
end

Then(/^I should( not)? be able to view the profile page for "(.*?)"$/) do |negate, email|
  user = User.find_by(email: email)
  same_user = user == @current_user
  path = same_user ? my_profile_path : user_path(user)
  profile_page_title =
    same_user ? I18n.t('users.show.self_title') : I18n.t('users.show.other_title', user_id: user.id)
  step "I should#{negate} be able to navigate to the \"#{path}\" page"
  step "the current path should#{negate} be \"#{path}\""
  step "I should#{negate} see the page title as \"#{profile_page_title}\""
end

Then(/^I should be able to view the profile pages for only "(.*?)"$/) do |emails|
  email_list = emails.split(/, | and /)
  User.all.each do |user|
    expect_ability = email_list.include?(user.email)
    step "I should#{expect_ability ? '' : ' not'} be able to view the profile page for \"#{user.email}\""
  end
end

Then(/^I should not be able to navigate to the edit user page for "(.*?)"$/) do |email|
  path = edit_user_path(User.find_by(email: email).id)
  step "I should not be able to navigate to the \"#{path}\" page"
end

Then(/^I should( not)? see the edit user page for "(.*?)"$/) do |negate, email|
  user = User.find_by(email: email)
  page_title = user == @current_user ? 'Edit My Profile' : "Edit User #{user.id}"
  step "the current path should#{negate} be \"#{edit_user_path(user.id)}\""
  step "I should#{negate} see the page title as \"#{page_title}\""
end

Then(/^I should( not)? see a link to "(.*?)'s?" profile page$/) do |negate, email|
  profile_user = User.find_by(email: email)
  same_user = profile_user == @current_user
  link_text = same_user ? 'My Profile' : email
  if profile_user
    link_path = same_user ? my_profile_path : user_path(profile_user)
    step "I should#{negate} see a link to \"#{link_path}\" that says \"#{link_text}\""
  else
    step "I should not see #{link_text}"
  end
end

Then(/^I should see links to the profile pages for only "(.*?)"$/) do |emails|
  email_list = emails.split(/, | and /)
  User.all.each do |user|
    expect_link = email_list.include?(user.email)
    step "I should#{expect_link ? '' : ' not'} see a link to \"#{user.email}'s\" profile page"
  end
end

Then(/^I should see search results for only the following users: "(.*?)"$/) do |users|
  email_list = users.split(/, | and /)
  User.all.each do |user|
    expect_user = email_list.include?(user.email)
    step "I should#{expect_user ? '' : ' not'} see a link to \"#{user.email}'s\" profile page"
  end
end

Then(/^I should see search suggestions for only the following users: "(.*?)"$/) do |users|
  email_list = users.split(/, | and /)
  User.all.each do |user|
    expect_suggestion = email_list.include?(user.email)
    expect(page).send(expect_suggestion ? :to : :to_not, have_css('div.tt-suggestion > p', text: /\A#{user.email}\z/))
  end
end

Then(/^I should see search results and suggestions for only the following users: "(.*?)"$/) do |users|
  step "I should see search results for only the following users: \"#{users}\""
  step "I should see search suggestions for only the following users: \"#{users}\""
end
