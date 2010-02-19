module Twitch
  module SMS
    class Message
      class << self
        PER_PAGE = 50
    
        def paginate(page=1, per_page=50)
          response = remote_service.get('/Messages', {:page => (page - 1), :num => per_page})
          MessageCollection.new(
            response['TwilioResponse']['SMSMessages']['SMSMessage'].map{|m| self.new(m)},
            response['TwilioResponse']['SMSMessages']['page'],
            response['TwilioResponse']['SMSMessages']['numpages'],
            response['TwilioResponse']['SMSMessages']['total'],
            response['TwilioResponse']['SMSMessages']['pagesize']
          )
        end
        
        def create(from, to, body, status_callback_url=nil)
          raise MessageTooLong if body.length > 160
          body = {:From => from, :To => to, :Body => body}
          body.merge!(:StatusCallback => status_callback_url) if status_callback_url
          response = remote_service.post('/Messages', {:body => body})
        end
        
        def find(sid)
          if response = remote_service.get("/Messages/#{sid}")
            Message.new(response['TwilioResponse']['SMSMessage'])
          end
        end
        
        def remote_service
          @@service ||= Service.new
          raise AuthorizationError, "You forgot to set your Twilio credentials: Twitch::SMS::Service.credentials(account_sid, auth_token)" unless @@service.credentialed
          @@service.class
        end
      end
  
      attr_accessor :sid, :date_created, :date_updated, :date_sent, :account_sid,
                    :to, :from, :body, :status, :flags, :price
  
      def initialize(twilio_hash)
        twilio_hash.each_pair do |k,v|
          instance_variable_set(symbolized_ivar(k), v)
        end
      end
  
      def date_created
        Time.parse(@date_created)
      end
      alias_method :created_at, :date_created
  
      def date_updated
        Time.parse(@date_updated)
      end
      alias_method :updated_at, :date_updated
  
      def date_sent
        Time.parse(@date_sent)
      end
      alias_method :sent_at, :date_sent
      
      def to_hash
        returning Hash.new() do |h|
          [:sid, :account_sid, :to, :from, :body, :status, :flags, :price].each do |k|
            h[k] = send(k)
          end
          [:date_created, :date_updated, :date_sent].each do |k|
            if value = send(k)
              h[k] = value.strftime("%a, %d %b %Y %H:%M:%S %z")
            else
              h[k] = ""
            end
          end
        end
      end
      
      private
        def symbolized_ivar(key)
          "@#{ActiveSupport::Inflector.underscore(key)}"
        end
    end
  end
end