@javascript
Feature: User Profile

  @authentication @failure
  Scenario: A visitor tries to view a user's profile
    Given I have not signed in
    Then I should not be able to view the profile page for "user1@user.com"
    And I should not be able to view the profile page for "admin1@admin.com"

  @authorization @read
  Scenario Outline: A user can only view certain profiles
    Given I have signed in as "<user>"
    Then I should be able to view the profile pages for only "<profiles>"

    Examples:
    	| user 			       | profiles			                                                      |
    	| user1@user.com   | user1@user.com, user2@user.com                                     |
    	| admin1@admin.com | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |

  @authorization @read
  Scenario Outline: A user sees certain actions on a profile
    Given I have signed in as "<user>"
    When I navigate to the profile page for "<profile>"
    Then I should see the following buttons: "<buttons>"
    And I should not see the following buttons: "<missing>"

    Examples:
      | user             | profile          | buttons            | missing      |
      | user1@user.com   | user1@user.com   | Edit, Delete, Home |              |
      | user1@user.com   | user2@user.com   | Home               | Edit, Delete |
      | admin1@admin.com | user1@user.com   | Edit, Delete, Home |              |
      | admin1@admin.com | admin1@admin.com | Edit, Delete, Home |              |
      | admin1@admin.com | admin2@admin.com | Edit, Delete, Home |              |

  @navigation
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

  @delete
  Scenario Outline: A user clicks the Delete button in their profile
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

  @delete @failure
  Scenario Outline: A user accidentally clicks the Delete button in their profile
    Given I have signed in as "<user>"
    And I have navigated to the "My Profile" page
    When I click on the "Delete" button
    And I dismiss the popup alert
    Then I should not be automatically signed out
    And I should be able to sign in as "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin1@admin.com |

  @delete
  Scenario Outline: An admin clicks the Delete button in a user's profile
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the profile page for "<user>"
    When I click on the "Delete" button
    And I accept the popup alert
    Then I should be redirected to the "home" page
    And I should see an alert message saying "Successfully deleted user."
    And I should see links to the profile pages for only "<remaining>"
    And I should not be able to sign in as "<user>"

    Examples:
      | user             | remaining                                          |
      | user1@user.com   | admin1@admin.com, admin2@admin.com, user2@user.com |
      | admin2@admin.com | admin1@admin.com, user1@user.com, user2@user.com   |
      