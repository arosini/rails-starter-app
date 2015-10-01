@javascript
Feature: Navbar

  Scenario Outline: User sees specific links in the navbar
    Given I have <status>
    Then I should see the "<links>" links in the navbar
    And I should not see the "<missing>" links in the navbar

    Examples:
      | status                          | links                                 | missing                               | 
      | signed in as "admin1@admin.com" | My Profile, Users, Roles and Sign Out | Welcome, Sign In and Sign Up          |
      | signed in as "user1@user.com"   | My Profile, Users and Sign Out        | Welcome, Sign In Sign Up and Roles    |
      | not signed in                   | Welcome, Sign In and Sign Up          | My Profile, Users, Roles and Sign Out |

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
      | My Profile | my profile | signed in as "user1@user.com"   |
      | Users      | home       | signed in as "user1@user.com"   |
      | Welcome    | landing    | not signed in                   |
      | Sign In    | sign in    | not signed in                   |
      | Sign Up    | sign up    | not signed in                   |


  Scenario Outline: Sign out button is clicked on
    Given I have signed in as "<user>"
    When I click on the "Sign Out" link in the navbar
    Then I should see the "landing" page

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |