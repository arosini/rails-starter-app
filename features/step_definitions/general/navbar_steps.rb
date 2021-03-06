# Put all steps that should be 'within_navbar' here.

# Given
Given(/^I have clicked on the "(.*?)" link in the navbar$/) do |link_text|
  within_navbar { click_on(link_text) }
end

# When
When(/^I click on the "(.*?)" link in the navbar$/) do |link_text|
  step "I have clicked on the \"#{link_text}\" link in the navbar"
end

# Then
Then(/^I should( not)? see the "(.*?)" links? in the navbar$/) do |negate, links|
  within_navbar do
    links.split(/, | and /).each do |link|
      expect(page).send(negate ? :to_not : :to, have_selector('a', text: link))
    end
  end
end

Then(/^only the "(.*?)" link in the navbar should indicate it is selected$/) do |link|
  within_navbar do
    expect(find('a', text: link).find(:xpath, '..')[:class]).to include('active')
    expect(page).to have_css('ul.nav > li.active', count: 1)
  end
end
