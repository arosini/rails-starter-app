@javascript
Feature: Landing Page

  Scenario Outline: A visitor clicks a button on the Landing page
    Given I have not signed in
    And I have navigated to the "Landing" page
    When I click on the "<action>" button
    Then I should see the "<page>" page

    Examples:
      | action  | page    | 
      | Sign In | Sign In |
      | Sign Up | Sign Up |

  Scenario Outline: A user/admin cannot access the Landing page
    Given I have signed in as "<user>"
    When I navigate to the "Landing" page
    Then I should see the "Users" page
    And I should not see the page title as "Landing Page!"
    And I should see the page title as "Users Index"

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |