module Twitch
  module SMS
    class Service
      @@credentialed = false
      cattr_accessor :credentialed
      
      include HTTParty
      format :xml
      
      def self.credentials(account_sid, auth_token)
        class_eval do
          @@credentialed = true
          base_uri "https://api.twilio.com/2008-08-01/Accounts/#{account_sid}/SMS"
          basic_auth account_sid, auth_token
        end
      end
    end
  end
end