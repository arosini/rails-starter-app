@javascript
Feature: Not Found

 @authentication @failure
 Scenario: A visitor tries to access a page which does not exist
   Given I have not signed in
   When I navigate to the "fake" page
   Then I should be redirected to the "Sign In" page
   And I should see an error alert message that says "You need to sign in or sign up before continuing."

 @navigation @failure
 Scenario: A user tries to access a page which does not exist
   Given I have signed in as "user1@user.com"
   When I navigate to the "fake" page
   Then I should see "The page you were looking for doesn't exist (404)" on the page