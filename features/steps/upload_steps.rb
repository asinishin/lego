Given(/^the service logged in to the destination server$/) do
  Lego::Api.login
end

When(/^the service obtained "(.*?)" of "(.*?)" site$/) do |arg1, arg2|
  @last_sourced_id = Lego::Api.last_id(arg2) 
end

When(/^the service uploaded the listing with data: "(.*?)"$/) do |arg1|
  item = @listings.find{ |e| e['Source Id'] == arg1 }
  listing = {
    title:               item['Title'],
    description:         item['Description'],
    space_type_id:       (item['Type of space'] == 'Indoor' ? 1 : 2),
    length:              item['Aprox: length'],
    width:               item['Aprox: width'],
    height:              item['Aprox: height'],
    is_for_vehicle:      item['Could be vehicle storage?'],
    is_small_transport:  false,
    is_large_transport:  false,
    rental_rate:         item['Monthly rental rate'],
    surface_id:          1,
    rental_term_id:      1,
    is_no_height:        false,
    source_site:         item['Source Site'],
    source_id:           item['Source Id']
  }
  address = {
    address:             item['Listing Address'],
    city:                item['City'],
    state_province:      item['State/Province'],
    zip_code:            item['Postal Code'],
    country_id:          1,
    latitude:            item['Latitude'],
    longitude:           item['Longitude']
  }
  @result = Lego::Api.upload_listing(listing, address)
  if @result
    item['Photo'].split(',').each do |e|
      Lego::Api.upload_photo(@result, Lego::Api::BASE_PHOTOS + e)
    end
  end
end

Then(/^the destination server should return the success status$/) do
#  pending # express the regexp above with the code you wish you had
end

Then(/^the service logged out$/) do
  Lego::Api.logout
end
