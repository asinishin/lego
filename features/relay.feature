Feature: Listing relay
  In case to be a proud hacker
  An owner of the service
  Wants to relay all Nobel laureats to production

  Scenario: Service relayed a listing
  # Given listings uploaded by "upload.feature" test!
  Given source site "test"
  When the service loaded a listing
  Then it should contain 
