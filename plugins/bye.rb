require 'date'

module GitterBot
  module Plugin
    module Bye
      def self.===(message)
        return false unless message.is_a? Message

        message.text.match(/^bye$/io)
      end

      def self.call(message)
        fail ArgumentError unless message.is_a? Message
        key = "timecard:#{message.user.id}:working"

        header = authorized_header(TOKEN, 'Content-Type' => 'application/json')
        working = REDIS.get key
        if working
          msg = build_message(message.user.username, working, message.sent)
          REDIS.pipelined do
            card = %({"start":"#{working}","end":"#{message.sent}"})
            REDIS.rpush 'timecard:' + message.user.id, card
          end
        else
          msg = message.user.username + ': There are no valid working data'
        end

        API.post(post_path(ROOM_ID), %({"text": "#{msg}"}), header)
      end

      private

      def self.build_message(name, s_date, e_date)
        s_time = Date.parse(s_date).to_time
        e_time = Date.parse(e_date).to_time
        hours = (e_time - s_time) / 3600
        "#{name}: finished for #{hours} HOURS from #{s_date}"
      end
    end
  end
end
