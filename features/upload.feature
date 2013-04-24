@given_listings

Feature: Listing uploader
  In case to be a proud hacker
  An owner of the service
  Wants to scrap all Nobel laureats from Wiki

  Scenario Outline: Service uploaded a listing to the destination server
  # Given: empty DB of destination server for the test!
  Given the service logged in to the destination server
  When the service obtained "<Last Listing Id>" of "test" site
  # And the service scrapped data after "<Last listing Id>"
  And  the service uploaded the listing with data: "<Source Id>"
  Then the destination server should return the success status
  And  the service logged out

  Scenarios:
    | Source Id | Last Listing Id |
    |    000001 |               0 |
    |    000002 |          000001 |
    |    000003 |          000002 |
    |    000004 |          000003 |
    |    000005 |          000004 |
    |    000006 |          000005 |
