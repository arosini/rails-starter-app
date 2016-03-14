@javascript
Feature: Home Page

  @authentication @navigation
  Scenario: The root path directs a visitor to the Landing page
    Given I have not signed in
    When I navigate to the "Home" page
    Then I should see the "Landing" page
    And I should see the page title as "Landing Page!"

  @navigation
  Scenario Outline: The root path directs a user/admin to the Users page
    Given I have signed in as "<user>"
    When I navigate to the "Home" page
    Then I should see the "Users" page
    And I should see the page title as "Users Index"

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |