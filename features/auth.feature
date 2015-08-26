@javascript
Feature: Auth

  Scenario: Visitor signs up successfully
    Given I have not signed in
    When I have navigated to the "Sign Up" page
    And I fill out the "sign up" form with the following values:
      | field    | value             |
      | Email    | new-user@user.com |
      | Password | asdqwe            |
      | Confirm  | asdqwe            |
    And I click on the "Sign Up" button
    Then I should be automatically signed in

  Scenario Outline: Vistor cannot sign up with invalid information
    Given I have not signed in
    When I navigate to the "Sign Up" page
    And I fill out the "sign up" form with the following values:
      | field    | value          |
      | Email    | user1@user.com |
      | Password | asdqwe         |
      | Confirm  | asdqwe         |
      | <field>  | <value>        | 
    And I click on the "Sign Up" button
    Then I should see an error message saying "<message>" near the "<field>" field

    Examples:
      | field      | value          | message                            |
      | Email      | invalidemail   | This value should be a valid email |
      | Email      | user1@user.com | Email has already been taken       |
      | Email      |                | Can't be blank                     |
      | Password   | asdqw          | Must be at least 6 characters      |
      | Password   |                | Can't be blank                     |
      | Confirm    | asdqwee        | Must match password                |
      | Confirm    |                | Can't be blank                     |

  Scenario Outline: Visitor signs in successfully
    Given I have not signed in
    When I sign in as "<user>"
    Then I should see the "home" page
    
    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario Outline: Visitor cannot sign in with invalid information
    Given I have not signed in
    When I navigate to the "Sign In" page
    And I enter the sign in information for "user1@user.com"
    And I enter "<value>" in the "<field>" field
    And I click on the "Sign In" button
    Then I should see an error message saying "<message>"

    Examples:
      | field       | value          | message                                        |
      | Email       | wrong@user.com | Could not find a user with that email address  |
      | Password    | wrong          | Incorrect password                             |

  Scenario: A visitor successfully changes their password and signs in
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

  Scenario Outline: An authenticated user cannot access the sign in page
    Given I have signed in as "<user>"
    When I navigate to the "Sign In" page
    Then I should see an error message saying "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario Outline: An authenticated user cannot access the sign up page
    Given I have signed in as "<user>"
    When I navigate to the "Sign Up" page
    Then I should see an error message saying "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario Outline: An authenticated user cannot access the forgot your password page
    Given I have signed in as "<user>"
    When I navigate to the "forgot your password" page
    Then I should see an error message saying "You are already signed in."

    Examples:
      | user             |
      | admin1@admin.com |
      | user1@user.com   |

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