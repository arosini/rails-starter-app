@javascript
Feature: Home Page
	
	Scenario Outline: The root path directs an athenticated user to the users index
    Given I have signed in as "<user>"
    When I navigate to the "home" page
    Then I should see the "users" page

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario: The root path directs an unathenticated visitor to the landing page
    Given I have not signed in
    When I navigate to the "home" page
    Then I should see the "landing" page