module LegoReceiver # Squirrel

  BASE_URL   = ENV['LEGO_BASE_URL']
  USER_EMAIL = ENV['LEGO_USER_EMAIL']
  USER_PSSW  = ENV['LEGO_USER_PSSW']

  class Api
    include Lego
    
    def self.instance
      @@api_agent ||= Api.new
    end

    def login
      _login(BASE_URL, USER_EMAIL, USER_PSSW)
    end

    def logout
      _logout(BASE_URL)
    end

    def upload_listing(listing, address)
      item = Lego::DEFAULT_LISTING.merge(listing)
      addr = Lego::DEFAULT_ADDRESS.merge(address)
      response = RestClient.post BASE_URL + '/api/listings.json', { listing: item, address: addr }, { cookies: @cookies }
      JSON.parse(response)['id']
    end

    def upload_photo(listing_id, file_path)
      item = {
        hosting_description_id: listing_id,
	image: File.new(file_path, 'rb')
      }
      RestClient.post BASE_URL + "/spaces/#{listing_id}/space_photos.json", { space_photo: item }, { cookies: @cookies } 
    end

    def upload_features_and_cautions(listing_id, is_indoor, features, cautions)
      if is_indoor
        params = {
          indoor_features: { '' => features },
          indoor_cautions: { '' => cautions }
	}
      else
        params = {
          outdoor_features: { '' => features },
          outdoor_cautions: { '' => cautions }
	}
      end
      RestClient.put BASE_URL + "/api/listings/#{listing_id}.json", params, { cookies: @cookies } 
    end

    def last_id(source_site)
      response = RestClient.get BASE_URL + "/api/listings/#{source_site}/last_id.json", cookies: @cookies
      JSON.parse(response)['id']
    end
  end

end
