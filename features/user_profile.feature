@javascript
Feature: Users

  Scenario: A visitor tries to view a user's profile
    Given I have not signed in
    Then I should not be able to view the profile page for "user1@user.com"
    And I should not be able to view the profile page for "admin1@admin.com"

  Scenario Outline: A user views other user's profiles
    Given I have signed in as "<user>"
    Then I should be able to view the profile pages for only "<profiles>"

    Examples:
    	| user 			       | profiles			                                                      |
    	| user1@user.com   | user1@user.com, user2@user.com                                     |
    	| admin1@admin.com | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |

  Scenario: A visitor tries to edit other users
    Given I have not signed in
    Then I should not be able to navigate to the edit user page for "user1@user.com"
    And I should not be able to navigate to the edit user page for "admin1@admin.com"

  Scenario: A user changes their email
    Given I have signed in as "user1@user.com"
    And I have navigated to the "My Profile" page
    And I click on the "Edit" button
    When I enter "updated@updated.com" in the "Email" field
    And I click on the "Submit" button
    Then I should see an alert message saying "Successfully updated user."
    And I should be able to sign in as "updated@updated.com" 
    And I should not be able to sign in as "user1@user.com"

  Scenario Outline: An admin changes a user's email
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the profile page for "<user>"
    And I have clicked on the "Edit" button
    When I enter "updated@updated.com" in the "Email" field
    And I click on the "Submit" button
    Then I should see an alert message saying "Successfully updated user."
    And I should not be able to sign in as "<user>"
    And I should be able to sign in as "updated@updated.com"

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |
      | admin2@admin.com |

  Scenario Outline: A user tries to change their email to an invalid value
    Given I have signed in as "<user>"
    And I have navigated to the "My Profile" page
    And I have clicked on the "Edit" button
    When I enter "<email>" in the "Email" field
    And I click on the "Submit" button
    Then I should see an error message saying "<message>" near the "Email" field

    Examples:
      | user             | email           | message                             |
      | user1@user.com   | user1           | This value should be a valid email. |
      | user1@user.com   | user2@user.com  | Email has already been taken.       |
      | admin1@admin.com | user1           | This value should be a valid email. |
      | admin1@admin.com | user2@user.com  | Email has already been taken.       |

  Scenario: A user changes their password
    Given I have signed in as "user1@user.com"
    And I have navigated to the "My Profile" page
    And I have clicked on the "Edit" button
    When I click on the "Change Password" button
    And I enter "asdqwe" in the "Current" field
    And I enter "asdqwe1" in the "New" field
    And I enter "asdqwe1" in the "Confirm" field
    And I click on the "Submit Password Change" button
    Then I should see an alert message saying "Successfully updated password!"
    And I should not be able to sign in as "user1@user.com" using "asdwqe" as the password
    And I should be able to sign in as "user1@user.com" using "asdwqe1" as the password

  Scenario Outline: A user tries to change their password with an invalid value
    Given I have signed in as "<user>"
    And I have navigated to the "My Profile" page
    And I have clicked on the "Edit" button
    When I click on the "Change Password" button
    And I enter "<current>" in the "Current" field
    And I enter "<new>" in the "New" field
    And I enter "<confirm>" in the "Confirm" field
    And I click on the "Submit Password Change" button
    Then I should see an error message saying "<message>" near the "<field>" field

    Examples:
      | user             | current | new    | confirm | field   | message                       |
      | user1@user.com   | asdqw   | asdqwe | asdqwe  | Current | Incorrect current password    |
      | user1@user.com   |         | asdqwe | asdqwe  | Current | Can't be blank                |
      | user1@user.com   | asdqwe  | asdqw  | asdqwe  | New     | Must be at least 6 characters |
      | user1@user.com   | asdqwe  |        |         | New     | Can't be blank                |
      | user1@user.com   | asdqwe  | asdqwe | asdqwee | Confirm | Must match password           |
      | user1@user.com   | asdqwe  |        |         | Confirm | Can't be blank                |
      | admin1@admin.com | asdqw   | asdqwe | asdqwe  | Current | Incorrect current password    |
      | admin1@admin.com |         | asdqwe | asdqwe  | Current | Can't be blank                |
      | admin1@admin.com | asdqwe  | asdqw  | asdqwe  | New     | Must be at least 6 characters |
      | admin1@admin.com | asdqwe  |        |         | New     | Can't be blank                |
      | admin1@admin.com | asdqwe  | asdqwe | asdqwee | Confirm | Must match password           |
      | admin1@admin.com | asdqwe  |        |         | Confirm | Can't be blank                |

  Scenario Outline: An admin tries to change another user's password
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the profile page for "<user>"
    When I click on the "Edit" button
    Then I should not see a "Change Password" button

    Examples:
      | user             |
      | user1@user.com   |
      | admin2@admin.com |
 
  Scenario: A user tries to change their roles
    Given I have signed in as "user1@user.com"
    And I have navigated to the "My Profile" page
    And I click on the "Edit" button
    Then I should not see "Role" on the page

  Scenario Outline: An admin changes a user's roles
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the profile page for "<user>"
    And I have clicked on the "Edit" button
    When I select "<roles>" in the "Roles" dropdown
    And I click on the "Submit" button
    Then I should see the profile page for "<user>"
    And I should see an alert message saying "Successfully updated user."
    And I should see "<roles>" in the "Role" row

    Examples:
      | user             | roles       |
      | user1@user.com   | Admin       |
      | user1@user.com   | User, Admin |
      | admin1@admin.com | User        |
      | admin1@admin.com | Admin, User |
      | admin2@admin.com | User        |
      | admin2@admin.com | Admin, User |

  Scenario: A user tries to delete other users
    Given I have signed in as "user1@user.com"
    When I navigate to the profile page for "user2@user.com"
    Then I should not see a "Delete" button

  Scenario Outline: A user deletes themself
    Given I have signed in as "<user>"
    And I have navigated to the "My Profile" page
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be automatically signed out
    And I should not be able to sign in as "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |

  Scenario: An admin deletes a user
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the profile page for "user1@user.com"
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be redirected to the "home" page
    And I should see an alert message saying "Successfully deleted user."
    And I should see links to the profile pages for only "admin1@admin.com, admin2@admin.com, user2@user.com"
    And I should not be able to sign in as "user1@user.com"