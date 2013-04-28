require 'rubygems'
require 'rest_client'
require 'json'

module Lego

  BASE_PHOTOS = ENV['LEGO_BASE_PHOTOS']

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

private

  def _login(base_url, email, password)
    response = RestClient.post base_url + '/api/sessions.json', email: email, password: password
    @cookies = response.cookies
  end

  def _logout(base_url)
    RestClient.delete base_url + '/api/sessions/123.json', cookies: @cookies
  end

end
