gem 'fakeweb', '1.2.8'
gem 'shoulda', '2.10.2'
gem 'mocha', '0.9.8'

require 'twitch'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'fakeweb'

class Test::Unit::TestCase
  FakeWeb.allow_net_connect = false

  ACCOUNT_SID = "AC5ea872f6da5a21de157d80997a64bd33"
  AUTH_TOKEN = "872fb94e3b358913777cdb313f25b46f"
  SMS_SID = "SMeb4db1283b0c7077737c02aa01a35941"

  message = <<-XML
    <?xml version="1.0"?>
    <TwilioResponse>
  		<SMSMessage>
  			<Sid>SMeb4db1283b0c7077737c02aa01a35941</Sid>
  			<AccountSid>AC5ea872f6da5a21de157d80997a64bd33</AccountSid>
  			<From>4155555555</From>
  			<To>4156666666</To>
  			<Body>Hey, wanna grab dinner?</Body>
  			<Status>sent</Status>
  			<Flags>4</Flags>
  			<Price>-0.03000</Price>
  			<DateCreated>Sun, 04 Oct 2009 03:48:08 -0700</DateCreated>
  			<DateUpdated>Sun, 04 Oct 2009 03:48:10 -0700</DateUpdated>
  			<DateSent>Sun, 04 Oct 2009 03:48:10 -0700</DateSent>
  		</SMSMessage>
    </TwilioResponse>
  XML
  
  list = <<-XML
    <?xml version="1.0"?>
    <TwilioResponse>
    	<SMSMessages page="0" numpages="2" pagesize="4" total="6" start="0" end="3">
    		<SMSMessage>
    			<Sid>SMeb4db1283b0c7077737c02aa01a35941</Sid>
    			<AccountSid>AC5ea872f6da5a21de157d80997a64bd33</AccountSid>
    			<From>4155555555</From>
    			<To>4156666666</To>
    			<Body>Hey, wanna grab dinner?</Body>
    			<Status>sent</Status>
    			<Flags>4</Flags>
    			<Price>-0.03000</Price>
    			<DateCreated>Sun, 04 Oct 2009 03:48:08 -0700</DateCreated>
    			<DateUpdated>Sun, 04 Oct 2009 03:48:10 -0700</DateUpdated>
    			<DateSent>Sun, 04 Oct 2009 03:48:10 -0700</DateSent>
    		</SMSMessage>
    		<SMSMessage>
    			<Sid>SM872fb94e3b358913777cdb313f25b46f</Sid>
    			<AccountSid>AC5ea872f6da5a21de157d80997a64bd33</AccountSid>
    			<From>4156666666</From>
    			<To>4155555555</To>
    			<Body>The judge said you can't text me anymore.</Body>
    			<Status>sent</Status>
    			<Flags>4</Flags>
    			<Price>-0.03000</Price>
    			<DateCreated>Sun, 04 Oct 2009 03:49:32 -0700</DateCreated>
    			<DateUpdated>Sun, 04 Oct 2009 03:49:34 -0700</DateUpdated>
    			<DateSent>Sun, 04 Oct 2009 03:48:34 -0700</DateSent>
    		</SMSMessage>
    		<SMSMessage>
    			<Sid>SMeb283b0c70774a01a35db1737c02a941</Sid>
    			<AccountSid>AC5ea872f6da5a21de157d80997a64bd33</AccountSid>
    			<From>4155555555</From>
    			<To>4156666666</To>
    			<Body>Did you get my email?</Body>
    			<Status>sent</Status>
    			<Flags>4</Flags>
    			<Price>-0.03000</Price>
    			<DateCreated>Sun, 04 Oct 2009 03:51:08 -0700</DateCreated>
    			<DateUpdated>Sun, 04 Oct 2009 03:51:10 -0700</DateUpdated>
    			<DateSent>Sun, 04 Oct 2009 03:51:10 -0700</DateSent>
    		</SMSMessage>
    		<SMSMessage>
    			<Sid>SM87e3b35891377f25b46f7c2fb94db313</Sid>
    			<AccountSid>AC5ea872f6da5a21de157d80997a64bd33</AccountSid>
    			<From>4156666666</From>
    			<To>4155555555</To>
    			<Body>I'm calling the cops.</Body>
    			<Status>sent</Status>
    			<Flags>4</Flags>
    			<Price>-0.03000</Price>
    			<DateCreated>Sun, 04 Oct 2009 03:52:48 -0700</DateCreated>
    			<DateUpdated>Sun, 04 Oct 2009 03:52:50 -0700</DateUpdated>
    			<DateSent>Sun, 04 Oct 2009 03:52:50 -0700</DateSent>
    		</SMSMessage>
    	</SMSMessages>
    </TwilioResponse>
  XML

  base_url = "https://#{ACCOUNT_SID}:#{AUTH_TOKEN}@api.twilio.com/2008-08-01/Accounts/#{ACCOUNT_SID}/SMS/Messages"
  FakeWeb.register_uri(:get, base_url, :body => list)
  FakeWeb.register_uri(:post, base_url, :body => message)
  FakeWeb.register_uri(:get, base_url + "/#{SMS_SID}", :body => message)
  
  def teardown
    Twitch::SMS::Service.credentialed = false
  end
  
  def inherited(base)
    base.define_method teardown do
      super
    end
  end
end