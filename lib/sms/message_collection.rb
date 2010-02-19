module Twitch
  module SMS
    class MessageCollection
      include Enumerable
      attr_reader :current_page, :total_pages, :total_messages, :per_page
  
      def initialize(messages, current_page, total_pages, total_messages, per_page)
        @messages = messages
        @current_page = current_page.to_i + 1
        @total_pages = total_pages.to_i
        @total_messages = total_messages.to_i
        @per_page = per_page.to_i
      end
      
      def inspect
        @messages.inspect
      end
      
      def each
        @messages.each{|m| yield m}
      end
      
      def first_page?
        current_page == 1
      end
  
      def last_page?
        current_page == total_pages
      end
      
      def next_page
        last_page? ? nil : current_page + 1
      end
      
      def size
        @messages.size
      end
    end
  end
end