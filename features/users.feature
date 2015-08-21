@javascript
Feature: Users

  Scenario: A visitor tries to access the new user page
    Given I have not signed in
    When I navigate to the "new user" page
    Then I should see an error message saying "You need to sign in or sign up before continuing."

  Scenario: A user tries to access the new user page
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "new user" page

  Scenario: An admin creates a new user
    Given I have signed in as "admin1@admin.com"
    When I navigate to the "new user" page
    And I fill out the "new user" form with the following values:
      | field                  | value         |
      | Email                  | test@test.com |
      | Password               | asdqwe        |
      | Password Confirmation  | asdqwe        |
    And I click on the "Submit" button
    Then I should be able to sign in as "test@test.com"

  Scenario Outline: A visitor tries to view a user's profile
    Given I have not signed in
    Then I should not be able to view the profile page for "<email>"

    Examples:
      | email            |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario: A user tries to view an admin's profile
    Given I have signed in as "user1@user.com"
    Then I should not be able to view the profile page for "admin1@admin.com"

  Scenario Outline: A user views another user's profile
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

  Scenario Outline: A user edits their email
    Given I have signed in as "<user>"
    And I have navigated to the edit user page for "<user>"
    When I enter "updated@updated.com" in the "Email" field
    And I click on the "Submit" button
    Then I should see an alert message saying "Successfully updated user."
    And I should be able to sign in as "updated@updated.com" 
    And I should not be able to sign in as "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |

  Scenario: A user edits their password
    Given I have signed in as "user1@user.com"
    And I have navigated to the edit user page for "user1@user.com"
    When I click on the "Change Password" button
    And I enter "asdqwe" in the "Current Password" field
    And I enter "asdqwe1" in the "Password" field
    And I enter "asdqwe1" in the "Password Confirmation" field
    And I click on the "Submit Password Change" button
    Then I should see an alert message saying "Successfully updated password!"
    And I should not be able to sign in as "user1@user.com" using "asdwqe" as the password
    And I should be able to sign in as "user1@user.com" using "asdwqe1" as the password

  Scenario: A user tries to edit their roles
    Given I have signed in as "user1@user.com"
    And I have navigated to the edit user page for "user1@user.com"
    Then I should not see "Role"

  Scenario: A user tries to edit another user
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the edit user page for "user2@user.com"
    And I should not be able to navigate to the edit user page for "admin1@admin.com"

  Scenario Outline: An admin edits a user's email
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the edit user page for "<user>"
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

  Scenario Outline: An admin edits a user's password
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the edit user page for "<user>"
    When I click on the "Change Password" button
    And I enter "asdqwe" in the "Current Password" field
    And I enter "asdqwe1" in the "Password" field
    And I enter "asdqwe1" in the "Password Confirmation" field
    And I click on the "Submit Password Change" button
    Then I should see an alert message saying "Successfully updated password!"
    And I should not be able to sign in as "<user>" using "asdwqe" as the password
    And I should be able to sign in as "<user>" using "asdwqe1" as the password

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |
      | admin2@admin.com |

  Scenario Outline: An admin changes a user's roles
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the edit user page for "<user>"
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

  Scenario: A user deletes themself
    Given I have signed in as "user1@user.com"
    And I have navigated to the "My Profile" page
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be automatically signed out
    And I should not be able to sign in as "user1@user.com"

  Scenario: An admin deletes a user from the user's profile
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the profile page for "user1@user.com"
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be redirected to the "home" page
    And I should see an alert message saying "Successfully deleted user."
    And I should see links to the profile pages for only "admin1@admin.com, admin2@admin.com, user2@user.com"
    And I should not be able to sign in as "user1@user.com"
    