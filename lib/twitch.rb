# sms = Twitch::SMS::Service.new
# sms.create('4082222222','4085555555','My message') # => #<Twitch::SMS::Message>
# sms.paginate # => #<Twitch::SMS::Messages>
# sms.find('SMckr487u43jksdksdjdjsgh') # => #<Twitch::SMS::Message>

module Twitch
  require 'rubygems'
  
  begin 
    # Versions >= 3.0 of active_support
    require 'active_support/all'
  rescue LoadError
    require 'activesupport'
  end
  
  require 'httparty'
  require 'time'
  require 'cgi'
  
  require 'sms/service'
  require 'sms/message_collection'
  require 'sms/message'
  
  class TwitchError < StandardError; end
  class AuthorizationError < TwitchError; end
  class MessageTooLong < TwitchError; end
end
