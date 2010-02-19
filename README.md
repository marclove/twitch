# Twitch
## A Twilio Client for Ruby

USAGE
-----

Set your credentials:

	Twitch::SMS::Service.credentials(<AccountSID>,<AuthToken>)

Create (and send) an SMS Message:

	@message = Twitch::SMS::Message.create("415-555-5555","415-666-6666","Hey, wanna grab dinner?")
	@message.from # => "415-555-5555"
	@message.to # => "415-666-6666"
	@message.status # => "queued"

Retrieve a previously created message:

	@message = Twitch::SMS::Message.find("SMeb4db1283b0c7077737c02aa01a35941")
	@message.from # => "415-666-6666"
	@message.to # => "415-555-5555"
	@message.body # => "The judge said you can't text me anymore"
	@message.status # => "sent"

Retrieve a paginated list of previously created messages:

	@messages = Twitch::SMS::Message.paginate
	@messages.current_page # => 1
	@messages.total_pages # => 5
	@messages.each do |m|
		puts m.body
	end
	# => "Hey, wanna grab dinner?"
	# => "The judge said you can't text me anymore."

Currently Twitch only supports Twilio's SMS service, but the intention is to create a full Twilio client.

Note on Patches/Pull Requests
-----------------------------
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2010 Marc Love. See LICENSE for details.
