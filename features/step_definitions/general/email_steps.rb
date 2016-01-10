# Put email related steps here.

# THEN
Then(/^an email is sent to "(.*?)" from "(.*?)"$/) do |recipient, sender|
  email = ActionMailer::Base.deliveries.first
  expect(email.from.first).to eq(sender)
  expect(email.to.first).to eq(recipient)
end

Then(/^an email with a password change link should be sent to "(.*?)"$/) do |user_email|
  email = ActionMailer::Base.deliveries.first
  step "an email is sent to \"#{user_email}\" from \"accounts@railsstarterapp.com\""
  expect(email.body).to include(user_email)
  expect(email.body).to include('Change my password')
end
