@javascript
Feature: Navbar

  Scenario: Unauthenticacted user sees specific links in the navbar
    Given I have not signed in
    Then I should see the "Welcome, Sign In and Sign Up" links in the navbar
    And I should not see the "My Profile, Users, Roles and Sign Out" links in the navbar


  Scenario Outline: User sees specific links in the navbar
    Given I have signed in as "<user>"
    Then I should see the "<links>" links in the navbar
    And I should not see the "<missing>" links in the navbar

    Examples:
      | user             | links                                 | missing                          | 
      | admin1@admin.com | My Profile, Users, Roles and Sign Out | Welcome, Sign In, Sign Up        |
      | user1@user.com   | My Profile, Users and Sign Out        | Welcome, Sign In, Sign Up, Roles |


  Scenario Outline: Navbar linked is clicked on
    Given I have <status>
    When I click on the "<link>" link in the navbar
    Then I should see the "<page>" page
    And only the "<link>" link in the navbar should indicate it is selected

    Examples:
      | link       | page       | status                          |
      | My Profile | my profile | signed in as "admin1@admin.com" |
      | Users      | home       | signed in as "admin1@admin.com" |
      | Roles      | roles      | signed in as "admin1@admin.com" |
      | Welcome    | landing    | not signed in                   |
      | Sign In    | sign in    | not signed in                   |
      | Sign Up    | sign up    | not signed in                   |