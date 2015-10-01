@javascript
Feature: User Update

  Scenario: A visitor successfully changes their password through the forgot your password form and signs in
    Given I have not signed in
    When I navigate to the "forgot your password" page
    And I enter "user1@user.com" in the "Email" field
    And I click on the "Submit" button
    Then I should be redirected to the "sign in" page
    And I should see an alert message saying "You will receive an email with instructions on how to change your password in a few minutes."
    And an email with a password change link should be sent to "user1@user.com"
    When I click on the link in the email
    And I fill out the "change your password" form with the following values:
     | field     | value  |
     | Password  | asdqwe |
     | Confirm   | asdqwe |
    And I click on the "Submit" button
    Then I should be automatically signed in
    And I should see an alert message saying "Your password was changed successfully. You are now signed in."

  Scenario Outline: A visitor submits the forgot password form with an invalid email
    Given I have not signed in
    When I navigate to the "forgot your password" page
    And I enter "<email>" in the "Email" field
    And I click on the "Submit" button
    Then I should see an error message saying "<message>" near the "Email" field

    Examples:
     | email               | message                                       |
     | idontexist@user.com | Could not find a user with that email address |
     | bad-email           | This value should be a valid email            |

  Scenario Outline: A visitor tries to changes their password to an invalid password
    When I navigate to the "forgot your password" page
    And I enter "user1@user.com" in the "Email" field
    And I click on the "Submit" button
    Then I should be redirected to the "sign in" page
    And I should see an alert message saying "You will receive an email with instructions on how to change your password in a few minutes."
    And an email with a password change link should be sent to "user1@user.com"
    When I click on the link in the email
    And I fill out the "change your password" form with the following values:
     | field    | value      |
     | Password | <password> |
     | Confirm  | <confirm>  |
    And I click on the "Submit" button
    Then I should see an error message saying "<message>" near the "<field>" field

    Examples:
      | password | confirm | field    | message                       |
      | asdqw    | asdqw   | Password | Must be at least 6 characters |
      |          |         | Password | Can't be blank                |
      | asdqwe   | asdqwee | Confirm  | Must match password           |
      |          |         | Confirm  | Can't be blank                |

  Scenario Outline: An authenticated user cannot access the forgot your password page
    Given I have signed in as "<user>"
    When I navigate to the "forgot your password" page
    Then I should see an error message saying "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario: A visitor tries to edit a user
    Given I have not signed in
    Then I should not be able to navigate to the edit user page for "user1@user.com"
    And I should not be able to navigate to the edit user page for "admin1@admin.com"

  Scenario: A user tries to edit another user
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the edit user page for "user2@user.com"
    And I should not be able to navigate to the edit user page for "admin1@admin.com"

  Scenario Outline: A user clicks the Edit button in a profile
    Given I have signed in as "<user>"
    When I navigate to the profile page for "<profile>"
    And I click on the "Edit" button
    Then I should see the edit user page for "<profile>"

    Examples:
      | user             | profile          |
      | user1@user.com   | user1@user.com   |
      | admin1@admin.com | user1@user.com   |
      | admin1@admin.com | admin1@admin.com |
      | admin1@admin.com | admin2@admin.com |

  Scenario Outline: A user changes their email
    Given I have signed in as "<user>"
    When I navigate to the edit user page for "<user>"
    And I enter "updated@updated.com" in the "Email" field
    And I click on the "Submit" button
    Then I should see an alert message saying "Successfully updated user."
    And I should be able to sign in as "updated@updated.com" 
    And I should not be able to sign in as "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |

  Scenario Outline: A user tries to change their email to an invalid value
    Given I have signed in as "<user>"
    And I have navigated to the edit user page for "<user>"
    When I enter "<email>" in the "Email" field
    And I click on the "Submit" button
    Then I should see an error message saying "<message>" near the "Email" field

    Examples:
      | user             | email           | message                             |
      | user1@user.com   | user1           | This value should be a valid email. |
      | user1@user.com   | user2@user.com  | Email has already been taken.       |
      | admin1@admin.com | user1           | This value should be a valid email. |
      | admin1@admin.com | user2@user.com  | Email has already been taken.       |

  Scenario Outline: An admin tries to change another user's email
    Given I have signed in as "admin1@admin.com"
    When I navigate to the edit user page for "<user>"
    Then I should not see an "Email" field

    Examples:
      | user             |
      | user1@user.com   |
      | admin2@admin.com |

  Scenario Outline: A user changes their password
    Given I have signed in as "<user>"
    And I have navigated to the edit user page for "<user>"
    When I click on the "Change Password" button
    And I enter "asdqwe" in the "Current" field
    And I enter "asdqwe1" in the "New" field
    And I enter "asdqwe1" in the "Confirm" field
    And I click on the "Submit Password Change" button
    Then I should see an alert message saying "Successfully updated password!"
    And I should not be able to sign in as "<user>" using "asdwqe" as the password
    And I should be able to sign in as "<user>" using "asdwqe1" as the password

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |

  Scenario Outline: A user tries to change their password with an invalid value
    Given I have signed in as "<user>"
    And I have navigated to the edit user page for "<user>"
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
    When I navigate to the edit user page for "<user>"
    Then I should not see a "Change Password" button

    Examples:
      | user             |
      | user1@user.com   |
      | admin2@admin.com |
 
  Scenario: A user tries to change their roles
    Given I have signed in as "user1@user.com"
    When I navigate to the edit user page for "user1@user.com"
    Then I should not see "Role" on the page

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