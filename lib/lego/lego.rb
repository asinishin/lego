require 'rubygems'
require 'rest_client'
require 'json'

module Lego # Squirrel

  BASE_URL     = ENV['LEGO_BASE_URL']
  BASE_PHOTOS  = ENV['LEGO_BASE_PHOTOS']
  USER_EMAIL   = ENV['LEGO_USER_EMAIL']
  USER_PSSW    = ENV['LEGO_USER_PSSW']

  DEFAULT_LISTING = {
    title:          'No title',
    description:    'No descritpion',
    space_type_id:  1,
    length:         1.0,
    width:          1.0,
    height:         1.0,
    is_for_vehicle: false,
    is_small_transport: false,
    is_large_transport: false,
    rental_rate:    10.00,
    surface_id:     1,
    rental_term_id: 1,
    is_no_height:   false,
    source_site:    'test'
  }

  DEFAULT_ADDRESS = {
    address:        'No street',
    city:           'No city',
    state_province: 'No province',
    zip_code:       'No ZIP',
    country_id:     1,
    latitude:       0.0,
    longitude:      0.0
  }

  class Api
    def self.login
      response = RestClient.post BASE_URL + '/api/sessions.json', email: USER_EMAIL, password: USER_PSSW
      @@cookies = response.cookies
    end

    def self.upload_listing(listing, address)
      item = DEFAULT_LISTING.merge(listing)
      addr = DEFAULT_ADDRESS.merge(address)
      response = RestClient.post BASE_URL + '/api/listings.json', { listing: item, address: addr }, { cookies: @@cookies }
      JSON.parse(response)['id']
    end

    def self.upload_photo(listing_id, file_path)
      item = {
        hosting_description_id: listing_id,
	image: File.new(BASE_PHOTOS + file_path, 'rb')
      }
      RestClient.post BASE_URL + "/spaces/#{listing_id}/space_photos.json", { space_photo: item }, { cookies: @@cookies } 
    end

    def self.download_listing(source_site, source_id)
    end

    def self.download_next_listing(source_site, last_source_id)
    end

    def self.last_id(source_site)
      response = RestClient.get BASE_URL + "/api/listings/#{source_site}/last_id.json", cookies: @@cookies
      JSON.parse(response)['id']
    end

    def self.logout
      RestClient.delete BASE_URL + '/api/sessions/123.json', cookies: @@cookies
    end
  end

end
