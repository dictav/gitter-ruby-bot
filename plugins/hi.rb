module GitterBot
  module Plugin
    module Hi
      def self.===(message)
        return false unless message.is_a? Message

        message.text.match(/^hi$/io)
      end

      def self.call(message)
        fail ArgumentError unless message.is_a? Message
        key = "timecard:#{message.user.id}:working"

        REDIS.pipelined do
          REDIS.set key, message.sent
          REDIS.expire key, 12 * 3600 # 12 hours
        end

        header = authorized_header(TOKEN, 'Content-Type' => 'application/json')
        msg = "#{message.user.username}: start at #{message.sent}"
        API.post(post_path(ROOM_ID), %({"text": "#{msg}"}), header)
      end
    end
  end
end
