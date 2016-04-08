# Put shared navigation steps here.

# GIVEN
Given(/^I have navigated to the "(.*?)" page$/) do |page_name|
  visit(pathify(page_name))
end

# WHEN
When(/^I navigate to the "(.*?)" page$/) do |page_name|
  step "I have navigated to the \"#{page_name}\" page"
end

When(/^I close and re-open the browser$/) do
  # Get cookies we want to keep
  remember_me_cookie = page.driver.browser.manage.cookie_named('remember_user_token')

  # Close the window and delete the cookies
  page.driver.quit

  # Re-open the window
  page.driver.switch_to_window(page.driver.current_window_handle)

  # Go to our domain and add our cookies back in
  visit('/')
  remember_me_cookie.nil? ? @current_user = nil : page.driver.browser.manage.add_cookie(remember_me_cookie)

  # Refresh the domain to activate the cookies
  visit('/')
end
