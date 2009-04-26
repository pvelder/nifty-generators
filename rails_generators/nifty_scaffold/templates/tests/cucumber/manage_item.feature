Feature: Manage <%= plural_class_name %>
  In order to manage <%= plural_name %>
  As a user
  I want to list, create, update, and show <%= plural_name %>

  Scenario: List <%= plural_class_name %>
    Given I have <%= plural_name %> titled <%= singular_class_name %>1, <%= singular_class_name %>2
    When I go to the list of <%= plural_name %>
    Then I should see 2 <%= plural_name %>
    And I should see "<%= singular_class_name %>1"
    And I should see "<%= singular_class_name %>2"

  Scenario: Create New <%= singular_class_name %>
    Given I have no <%= plural_name %>
    And I go to the list of <%= plural_name %>
    And I follow "New <%= singular_class_name %>"
    And I fill in "Subject" with "Hello World"
    And I fill in "Body" with "This is a new <%= singular_name %> message."
    When I press "Create <%= singular_class_name %>"
    Then I should see 1 <%= singular_name %>
    And I should see "Successfully created <%= singular_name %>."
    And I should see "Hello World"
    And I should see "This is a new <%= singular_name %> message."

  Scenario: Edit <%= singular_class_name %>
    Given I have <%= singular_name %> titled <%= singular_class_name %>1
    And I go to the list of <%= plural_name %>
    And I follow "Edit"
    And I fill in "Subject" with "Hello World"
    And I fill in "Body" with "This is a edit post message."
    When I press "Update <%= singular_class_name %>"
    And I should see "Successfully updated <%= singular_name %>."
    And I should see "Hello World"
    And I should see "This is a edit <%= singular_name %> message."


  Scenario: Delete <%= singular_class_name %>
    Given I have <%= singular_name %> titled <%= singular_class_name %>1
    And I go to the list of <%= plural_name %>
    When I follow "Remove"
    Then I have no <%= plural_name %>
    And I should see "Successfully removed <%= singular_name %>." 
