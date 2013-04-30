Given(/^source site "(.*?)"$/) do |arg1|
  @source_site = arg1
  @relay = LegoRelay::Api.instance
  @relay.login
end

When(/^the service loaded a listing$/) do
  @listing = @relay.load_listing(@source_site)
end

When(/^the service loaded photos$/) do
  @relay.load_photos(@listing[:photos])
end

Then(/^it should contain$/) do
  @relay.change_owner(@listing[:listing][:id])
  @relay.logout
end
