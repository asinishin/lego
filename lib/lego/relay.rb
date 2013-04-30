require 'mechanize'

module LegoRelay # Squirrel

  BASE_URL   = ENV['LEGOR_BASE_URL']
  USER_EMAIL = ENV['LEGOR_USER_EMAIL']
  USER_PSSW  = ENV['LEGOR_USER_PSSW']
  COMPLETE_EMAIL = ENV['LEGOR_COMPLETE_EMAIL']

  class Api
    include Lego
    
    def self.instance
      @@api_agent ||= Api.new
    end

    def agent
      @agent ||= Mechanize.new
    end

    def login
      _login(BASE_URL, USER_EMAIL, USER_PSSW)
    end

    def logout
      _logout(BASE_URL)
    end

    def load_listing(source_site)
      response = RestClient.get "#{BASE_URL}/api/listings/#{source_site}.json", { cookies: @cookies }
      response = JSON.parse(response).decamelize.symbolize_keys
      {
        listing: response[:listing].decamelize.symbolize_keys,
	address: response[:address].decamelize.symbolize_keys,
	photos:  response[:photos].map { |e| e.symbolize_keys },
	indoor_features:  response[:indoor_features].map { |e| e.decamelize.symbolize_keys },
	outdoor_features: response[:outdoor_features].map { |e| e.decamelize.symbolize_keys },
	indoor_cautions:  response[:indoor_cautions].map { |e| e.decamelize.symbolize_keys },
	outdoor_cautions: response[:outdoor_cautions].map { |e| e.decamelize.symbolize_keys }
      }
    end

    def load_photos(photos)
      photos.each do |photo|
        agent.get(photo[:url]).save_as(Lego::BASE_PHOTOS + photo[:file])
      end
    end

    def change_owner(listing_id)
      response = RestClient.put "#{BASE_URL}/api/listings/#{listing_id}/change_owner.json", { space_user_email: COMPLETE_EMAIL }, { cookies: @cookies }
    end
  end

end
