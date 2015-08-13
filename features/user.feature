@javascript
Feature: User

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

  Scenario: A user tries to access the new user page
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the "new user" page

  Scenario: A visitor tries to access the new user page
    Given I have not signed in
    When I navigate to the "new user" page
    Then I should see an error message saying "You need to sign in or sign up before continuing."

  Scenario Outline: A user tries to view another user's profile
    Given I have signed in as "<user>"
    And I have navigated to the "home" page
    Then I should see links to the profile pages for only "<profiles>"
    And I should be able to view the profile pages for only "<profiles>"

    Examples:
    	| user 			       | profiles			                                                      |
    	| user1@user.com   | user1@user.com, user2@user.com                                     |
    	| admin1@admin.com | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |

  Scenario Outline: A visitor tries to view a user's profile
    Given I have not signed in
    Then I should not be able to view the profile page for "<email>"

    Examples:
      | email            |
      | admin1@admin.com |
      | user1@user.com   |

  Scenario Outline: A user searches for another user
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    When I search with the following values:
      | field | value    |
      | Email | <search> |
    Then I should see <results> for only the following users: "<users>"

    Examples:
      | user             | search | users                                                              | results                        |  
      | user1@user.com   |        | user1@user.com, user2@user.com                                     | search results                 |  
      | user1@user.com   | user2  | user2@user.com                                                     | search results and suggestions |  
      | user1@user.com   | a      |                                                                    | search results and suggestions |  
      | admin1@admin.com |        | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com | search results                 |  
      | admin1@admin.com | u      | user1@user.com, user2@user.com                                     | search results and suggestions |  
      | admin1@admin.com | user2  | user2@user.com                                                     | search results and suggestions |  
      | admin1@admin.com | a      | admin1@admin.com, admin2@admin.com                                 | search results and suggestions |  
      | admin1@admin.com | admin2 | admin2@admin.com                                                   | search results and suggestions |

  Scenario: A visitor tries to edit users
    Given I have not signed in
    Then I should not be able to navigate to the edit user page for "user1@user.com"
    And I should not be able to navigate to the edit user page for "admin1@admin.com"

  Scenario Outline: A user tries to edit themselves
    Given I have signed in as "<user>"
    And I have navigated to the edit user page for "<user>"
    And I enter "updated@updated.com" in the "Email" field
    And I click on the "Submit" button
    Then I should be able to sign in as "updated@updated.com" 
    And I should not be able to sign in as "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |

  Scenario: A user tries to edit other users
    Given I have signed in as "user1@user.com"
    Then I should not be able to navigate to the edit user page for "user2@user.com"
    And I should not be able to navigate to the edit user page for "admin1@admin.com"

  Scenario Outline: An admin edits other users
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the edit user page for "<user>"
    And I enter "updated@updated.com" in the "Email" field
    And I click on the "Submit"
    Then I should be able to sign in as "updated@updated.com"
    And I should not be able to sign in as "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin2@admin.com |


  Scenario: A user cannot delete other users
    Given I have signed in as "user1@user.com"
    And I have navigated to the "Users" page
    Then I should not see "Delete"
    When I navigate to the profile page for "user2@user.com"
    Then I should not see "Delete"

  Scenario: A user deletes themselves
    Given I have signed in as "user1@user.com"
    And I have navigated to the "My Profile" page
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be automatically signed out
    And I should not be able to sign in as "user1@user.com"
  
  Scenario: An admin deletes a user from the users index
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Users" page
    When I click on the "Delete" button in the "user1@user.com" row
    And I accept the popup alert
    Then I should see an alert message saying "Successfully deleted user."
    And I should see links to the profile pages for only "admin1@admin.com, admin2@admin.com, user2@user.com"
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
    