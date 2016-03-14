@javascript
Feature: Navbar

  @authorization
  Scenario Outline: There are specific links in the navbar for a vistor/user/admin
    Given I have <status>
    Then I should see the "<links>" links in the navbar
    And I should not see the "<missing>" links in the navbar

    Examples:
      | status                          | links                                 | missing                               | 
      | signed in as "admin1@admin.com" | My Profile, Users, Roles and Sign Out | Welcome, Sign In and Sign Up          |
      | signed in as "user1@user.com"   | My Profile, Users and Sign Out        | Welcome, Sign In Sign Up and Roles    |
      | not signed in                   | Welcome, Sign In and Sign Up          | My Profile, Users, Roles and Sign Out |

  @navigation
  Scenario Outline: Navbar linked is clicked on by a vistor/user/admin
    Given I have <status>
    When I click on the "<link>" link in the navbar
    Then I should see the "<page>" page
    And only the "<link>" link in the navbar should indicate it is selected

    Examples:
      | link       | page       | status                          |
      | My Profile | My Profile | signed in as "admin1@admin.com" |
      | Users      | Home       | signed in as "admin1@admin.com" |
      | Roles      | Roles      | signed in as "admin1@admin.com" |
      | My Profile | My Profile | signed in as "user1@user.com"   |
      | Users      | Home       | signed in as "user1@user.com"   |
      | Welcome    | Landing    | not signed in                   |
      | Sign In    | Sign In    | not signed in                   |
      | Sign Up    | Sign Up    | not signed in                   |

  @authentication @navigation
  Scenario Outline: Sign out button is clicked on by an user/admin
    Given I have signed in as "<user>"
    When I click on the "Sign Out" link in the navbar
    Then I should see the "Landing" page

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |