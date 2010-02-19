require 'test_helper'

class MessageTest < Test::Unit::TestCase
  include Twitch::SMS

  context "Without authorization" do
    should "should raise AuthorizationError" do
      assert_raise Twitch::AuthorizationError do
        Message.paginate
      end
      assert_raise Twitch::AuthorizationError do
        Message.find(SMS_SID)
      end
      assert_raise Twitch::AuthorizationError do
        Message.create('4155555555','4156666666','message')
      end
    end
  end
  
  context "With authorization:" do
    setup do
      Service.credentials(ACCOUNT_SID, AUTH_TOKEN)
      
      def initialized_message
        Message.new(
    			'Sid' => 'SMeb4db1283b0c7077737c02aa01a35941',
    			'AccountSid' => 'AC5ea872f6da5a21de157d80997a64bd33',
    			'From' => '4155555555',
    			'To' => '4156666666',
    			'Body' => 'Hey, wanna grab dinner?',
    			'Status' => 'sent',
    			'Flags' => '4',
    			'Price' => '-0.03000',
    			'DateCreated' => 'Sun, 04 Oct 2009 03:48:08 -0700',
    			'DateUpdated' => 'Sun, 04 Oct 2009 03:48:10 -0700',
    			'DateSent' => 'Sun, 04 Oct 2009 03:48:10 -0700'
        )
      end
    end
    
    should "initialize a message with a hash of data from Twilio" do
      assert initialized_message
    end
    
    context "a message" do
      setup do
        @message = initialized_message
      end
      
      should "have an sid attribute" do
        assert_equal 'SMeb4db1283b0c7077737c02aa01a35941', @message.sid
      end
      
      should "have an account_sid attribute" do
        assert_equal 'AC5ea872f6da5a21de157d80997a64bd33', @message.account_sid
      end
      
      should "have a from phone number attribute" do
        assert_equal '4155555555', @message.from
      end
      
      should "have a to phone number attribute" do
        assert_equal '4156666666', @message.to
      end
      
      should "have a body attribute" do
        assert_equal 'Hey, wanna grab dinner?', @message.body
      end
      
      should "have a status attribute" do
        assert_equal 'sent', @message.status
      end
      
      should "have a flags attribute" do
        assert_equal '4', @message.flags
      end
      
      should "have a price attribute" do
        assert_equal '-0.03000', @message.price
      end
      
      should "have a date_created attribute" do
        assert_equal Time.parse('Sun, 04 Oct 2009 03:48:08 -0700'), @message.date_created
      end
      
      should "have a created_at attribute" do
        assert_equal Time.parse('Sun, 04 Oct 2009 03:48:08 -0700'), @message.created_at
      end
      
      should "have a date_updated attribute" do
        assert_equal Time.parse('Sun, 04 Oct 2009 03:48:10 -0700'), @message.date_updated
      end
      
      should "have an updated_at attribute" do
        assert_equal Time.parse('Sun, 04 Oct 2009 03:48:10 -0700'), @message.updated_at
      end
      
      should "have a date_sent attribute" do
        assert_equal Time.parse('Sun, 04 Oct 2009 03:48:10 -0700'), @message.date_sent
      end
      
      should "have a sent_at attribute" do
        assert_equal Time.parse('Sun, 04 Oct 2009 03:48:10 -0700'), @message.sent_at
      end
      
      should "be convertible into a hash" do
        hash = {
          :sid => 'SMeb4db1283b0c7077737c02aa01a35941',
    			:account_sid => 'AC5ea872f6da5a21de157d80997a64bd33',
    			:from => '4155555555',
    			:to => '4156666666',
    			:body => 'Hey, wanna grab dinner?',
    			:status => 'sent',
    			:flags => '4',
    			:price => '-0.03000',
    			:date_created => 'Sun, 04 Oct 2009 03:48:08 -0700',
    			:date_updated => 'Sun, 04 Oct 2009 03:48:10 -0700',
    			:date_sent => 'Sun, 04 Oct 2009 03:48:10 -0700'
        }
        assert_equal hash, @message.to_hash
      end
    end
    
    should "find a message" do
      @message = Message.find(SMS_SID)
      assert @message.is_a?(Message)
      assert_equal SMS_SID, @message.sid
    end
    
    context "a paginated collection of messages" do
      setup do
        @messages = Message.paginate
      end
      
      should "know what page it is on" do
        assert_equal 1, @messages.current_page
      end
      
      should "know how many total pages there are" do
        assert_equal 2, @messages.total_pages
      end
      
      should "know if its on the first page" do
        assert @messages.first_page?
      end
      
      should "know if its on the last page" do
        assert !@messages.last_page?
      end
      
      should "know its next page" do
        assert_equal 2, @messages.next_page
      end
      
      should "know how many total messages there are" do
        assert_equal 6, @messages.total_messages
      end
      
      should "know how many messages are on each page" do
        assert_equal 4, @messages.per_page
      end
      
      should "know the size of the current set of messages" do
        assert_equal 4, @messages.size
      end
      
      should "have an each method that iterates through its message objects" do
        @messages.each do |m|
          assert m.is_a?(Message)
        end
      end
    end
  end
end