@javascript
Feature: Users Index

  Scenario: A user does not see the New User button
    Given I have signed in as "user1@admin.com"
    When I navigate to the "Users" page
    Then I should not see a "New User" button

  Scenario: An admin clicks the New User button
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Users" page
    When I click on the "New User" button
    Then I should see the "New User" page

  Scenario Outline: A user/admin searches for other users using the Email contains search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    When I enter "<search>" in the "Email" contains search field
    Then I should see <results> for only the following users: "<users>"

    Examples:
      | user             | search | users                                                              | results                        |
      | user1@user.com   |        | user1@user.com, user2@user.com                                     | search results                 |
      | user1@user.com   | user   | user1@user.com, user2@user.com                                     | search results and suggestions |
      | user1@user.com   | user1  | user1@user.com                                                     | search results and suggestions |
      | user1@user.com   | user2  | user2@user.com                                                     | search results and suggestions |
      | user1@user.com   | a      |                                                                    | search results and suggestions |
      | admin1@admin.com |        | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com | search results                 |
      | admin1@admin.com | u      | user1@user.com, user2@user.com                                     | search results and suggestions |
      | admin1@admin.com | user2  | user2@user.com                                                     | search results and suggestions |
      | admin1@admin.com | a      | admin1@admin.com, admin2@admin.com                                 | search results and suggestions |
      | admin1@admin.com | admin1 | admin1@admin.com                                                   | search results and suggestions |
      | admin1@admin.com | admin2 | admin2@admin.com                                                   | search results and suggestions |

  Scenario Outline: A user/admin searches for other users using the Email equals search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have checked the "Email exact match" checkbox
    When I enter "<search>" in the "Email" equals search field
    Then I should see search results for only the following users: "<results>"
    And I should see search suggestions for only the following users: "<suggestions>"

    Examples:
      | user             | search           | results                                                            | suggestions                        |
      | user1@user.com   |                  | user1@user.com, user2@user.com                                     |                                    |
      | user1@user.com   | u                |                                                                    | user1@user.com, user2@user.com     |
      | user1@user.com   | user1            |                                                                    | user1@user.com                     |
      | user1@user.com   | user1@user.com   | user1@user.com                                                     | user1@user.com                     |
      | user1@user.com   | user1@user.comm  |                                                                    |                                    |
      | user1@user.com   | user2            |                                                                    | user2@user.com                     |
      | user1@user.com   | user2@user.com   | user2@user.com                                                     | user2@user.com                     |
      | user1@user.com   | user2@user.comm  |                                                                    |                                    |
      | user1@user.com   | a                |                                                                    |                                    |
      | admin1@admin.com |                  | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |                                    |
      | admin1@admin.com | u                |                                                                    | user1@user.com, user2@user.com     |
      | admin1@admin.com | user2            |                                                                    | user2@user.com                     |
      | admin1@admin.com | user2@user.com   | user2@user.com                                                     | user2@user.com                     |
      | admin1@admin.com | user2@user.comm  |                                                                    |                                    |
      | admin1@admin.com | a                |                                                                    | admin1@admin.com, admin2@admin.com |
      | admin1@admin.com | admin2           |                                                                    | admin2@admin.com                   |
      | admin1@admin.com | admin2@admin.com | admin2@admin.com                                                   | admin2@admin.com                   |
      | admin1@admin.com | admin1           |                                                                    | admin1@admin.com                   |
      | admin1@admin.com | admin1@admin.com | admin1@admin.com                                                   | admin1@admin.com                   |

  Scenario Outline: A user/admin searches for other users using the ID range search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have clicked on the "Advanced Search" button
    When I enter "<gteq>" in the "ID" greater than or equals search field
    And I enter "<lteq>" in the "ID" less than or equals search field
    Then I should see search results for only the following users: "<results>"

     Examples:
       | user             | gteq | lteq  | results                                                            |
       | user1@user.com   |      |       | user1@user.com, user2@user.com                                     |
       | user1@user.com   | 3    |       | user1@user.com, user2@user.com                                     |
       | user1@user.com   | 4    |       | user2@user.com                                                     |
       | user1@user.com   | 5    |       |                                                                    |
       | user1@user.com   |      | 4     | user1@user.com, user2@user.com                                     |
       | user1@user.com   |      | 3     | user1@user.com                                                     |
       | user1@user.com   |      | 2     |                                                                    |
       | user1@user.com   | 3    | 4     | user1@user.com, user2@user.com                                     |
       | user1@user.com   | 3    | 3     | user1@user.com                                                     |
       | user1@user.com   | 4    | 4     | user2@user.com                                                     |
       | admin1@admin.com |      |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com | 0    |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com | 4    |       | user2@user.com                                                     |
       | admin1@admin.com | 5    |       |                                                                    |
       | admin1@admin.com |      | 4     | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com |      | 1     | admin1@admin.com                                                   |
       | admin1@admin.com |      | 0     |                                                                    |
       | admin1@admin.com | 1    | 4     | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com | 2    | 3     | admin2@admin.com, user1@user.com                                   |
       | admin1@admin.com | 4    | 4     | user2@user.com                                                     |

  Scenario Outline: A user/admin searches for other users using the ID equals search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have clicked on the "Advanced Search" button
    And I have unchecked the "ID toggle range" checkbox
    When I enter "<id>" in the "ID" equals search field
    Then I should see search results for only the following users: "<results>"

    Examples:
      | user             | id | results                                                            |
      | user1@user.com   |    | user1@user.com, user2@user.com                                     |
      | user1@user.com   | 1  |                                                                    |
      | user1@user.com   | 3  | user1@user.com                                                     |
      | user1@user.com   | 4  | user2@user.com                                                     |
      | admin1@admin.com |    | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
      | admin1@admin.com | 1  | admin1@admin.com                                                   |
      | admin1@admin.com | 2  | admin2@admin.com                                                   |
      | admin1@admin.com | 3  | user1@user.com                                                     |
      | admin1@admin.com | 4  | user2@user.com                                                     |
      | admin1@admin.com | 5  |                                                                    |

  Scenario Outline: A user/admin searches for other users using the Role contains search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have clicked on the "Advanced Search" button
    When I enter "<role>" in the "Role" contains search field
    Then I should see search results for only the following users: "<results>"
    And I should see search suggestions for only the following roles: "<suggestions>"

    Examples:
      | user             | role  | results                                                            | suggestions |
      | user1@user.com   |       | user1@user.com, user2@user.com                                     |             |
      | user1@user.com   | a     |                                                                    | Admin       |
      | user1@user.com   | Admin |                                                                    | Admin       |
      | user1@user.com   | u     | user1@user.com, user2@user.com                                     | User        |
      | user1@user.com   | User  | user1@user.com, user2@user.com                                     | User        |
      | user1@user.com   | x     |                                                                    |             |
      | admin1@admin.com |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |             |
      | admin1@admin.com | a     | admin1@admin.com, admin2@admin.com                                 | Admin       |
      | admin1@admin.com | Admin | admin1@admin.com, admin2@admin.com                                 | Admin       |
      | admin1@admin.com | u     | user1@user.com, user2@user.com                                     | User        |
      | admin1@admin.com | User  | user1@user.com, user2@user.com                                     | User        |
      | admin1@admin.com | x     |                                                                    |             |

  Scenario Outline: A user/admin searches for other users using the Role equals search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have clicked on the "Advanced Search" button
    And I have checked the "Role exact match" checkbox
    When I enter "<role>" in the "Role" equals search field
    Then I should see search results for only the following users: "<results>"
    And I should see search suggestions for only the following roles: "<suggestions>"

     Examples:
      | user             | role  | results                                                            | suggestions |
      | user1@user.com   |       | user1@user.com, user2@user.com                                     |             |
      | user1@user.com   | a     |                                                                    | Admin       |
      | user1@user.com   | Admin |                                                                    | Admin       |
      | user1@user.com   | u     |                                                                    | User        |
      | user1@user.com   | User  | user1@user.com, user2@user.com                                     | User        |
      | user1@user.com   | x     |                                                                    |             |
      | admin1@admin.com |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |             |
      | admin1@admin.com | a     |                                                                    | Admin       |
      | admin1@admin.com | Admin | admin1@admin.com, admin2@admin.com                                 | Admin       |
      | admin1@admin.com | u     |                                                                    | User        |
      | admin1@admin.com | User  | user1@user.com, user2@user.com                                     | User        |
      | admin1@admin.com | x     |                                                                    |             |

  Scenario Outline: A user/admin searches for other users using the Sign In Count range search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have clicked on the "Advanced Search" button
    When I enter "<gteq>" in the "Sign In Count" greater than or equals search field
    And I enter "<lteq>" in the "Sign In Count" less than or equals search field
    Then I should see search results for only the following users: "<results>"

     Examples:
       | user             | gteq | lteq  | results                                                            |
       | user1@user.com   |      |       | user1@user.com, user2@user.com                                     |
       | user1@user.com   | 0    |       | user1@user.com, user2@user.com                                     |
       | user1@user.com   | 1    |       | user1@user.com                                                     |
       | user1@user.com   | 2    |       |                                                                    |
       | user1@user.com   |      | 1     | user1@user.com, user2@user.com                                     |
       | user1@user.com   |      | 0     | user2@user.com                                                     |
       | user1@user.com   | 0    | 1     | user1@user.com, user2@user.com                                     |
       | user1@user.com   | 0    | 0     | user2@user.com                                                     |
       | user1@user.com   | 1    | 1     | user1@user.com                                                     |
       | admin1@admin.com |      |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com | 0    |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com | 1    |       | admin1@admin.com                                                   |
       | admin1@admin.com | 2    |       |                                                                    |
       | admin1@admin.com |      | 1     | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com |      | 0     | admin2@admin.com, user1@user.com, user2@user.com                   |
       | admin1@admin.com | 0    | 1     | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
       | admin1@admin.com | 0    | 0     | admin2@admin.com, user1@user.com, user2@user.com                   |
       | admin1@admin.com | 1    | 1     | admin1@admin.com                                                   |

  Scenario Outline: A user/admin searches for other users using the Sign In Count equals search field
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    And I have clicked on the "Advanced Search" button
    And I have unchecked the "Sign In Count toggle range" checkbox
    When I enter "<count>" in the "Sign In Count" equals search field
    Then I should see search results for only the following users: "<results>"

    Examples:
      | user             | count | results                                                            |
      | user1@user.com   |       | user1@user.com, user2@user.com                                     |
      | user1@user.com   | 0     | user2@user.com                                                     |
      | user1@user.com   | 1     | user1@user.com                                                     |
      | user1@user.com   | 2     |                                                                    |
      | admin1@admin.com |       | admin1@admin.com, admin2@admin.com, user1@user.com, user2@user.com |
      | admin1@admin.com | 0     | admin2@admin.com, user1@user.com, user2@user.com                   |
      | admin1@admin.com | 1     | admin1@admin.com                                                   |
      | admin1@admin.com | 2     |                                                                    |

  Scenario Outline: A user/admin sees specific actions for each user
    Given I have signed in as "<user>"
    When I navigate to the "Users" page
    Then I should see the following actions in the "<row>" row: "<actions>"
    And I should not see the following actions in the "<row>" row: "<missing>"

    Examples:
     | user             | row              | actions            | missing                  |
     | user1@user.com   | user1@user.com   | My Profile         | Show, Edit, Delete       |
     | user1@user.com   | user2@user.com   | Show               | Edit, Delete, My Profile |
     | admin1@admin.com | user1@user.com   | Show, Edit, Delete | My Profile               |
     | admin1@admin.com | admin1@admin.com | My Profile         | Show, Edit, Delete       |
     | admin1@admin.com | admin2@admin.com | Show, Edit, Delete | My Profile               |

  Scenario Outline: An user/admin clicks the My Profile button
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    When I click on the "My Profile" button in the "<user>" row
    Then I should see the "My Profile" page
    And I should see the profile page for "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin2@admin.com |

  Scenario Outline: A user/admin clicks the Show button for a user/admin
    Given I have signed in as "<user>"
    And I have navigated to the "Users" page
    When I click on the "Show" button in the "<profile>" row
    Then I should see the profile page for "<profile>"

    Examples:
      | user             | profile          |
      | user1@user.com   | user2@user.com   |
      | admin1@admin.com | user1@user.com   |
      | admin1@admin.com | admin2@admin.com |

  Scenario Outline: An admin clicks the Edit button for a user/admin
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Users" page
    When I click on the "Edit" button in the "<user>" row
    Then I should see the edit user page for "<user>"

    Examples:
      | user             |
      | user1@user.com   |
      | admin2@admin.com |

  Scenario Outline: An admin clicks the Delete button for a user/admin
    Given I have signed in as "admin1@admin.com"
    And I have navigated to the "Users" page
    When I click on the "Delete" button in the "<user>" row
    And I accept the popup alert
    Then I should see an alert message saying "Successfully deleted user."
    And I should see links to the profile pages for only "<remaining>"
    And I should not be able to sign in as "<user>"

    Examples:
      | user             | remaining                                          |
      | user1@user.com   | admin1@admin.com, admin2@admin.com, user2@user.com |
      | admin2@admin.com | admin1@admin.com, user1@user.com, user2@user.com   |