require 'eventmachine'
require 'em-http'
require 'json'
require 'redis'
require 'logger'
require 'net/https'

require './helper.rb'
Dir['./plugins/*.rb'].each { |file| require file }

include GitterBot::Plugin

API_HOST = URI('https://api.gitter.im')
API = Net::HTTP.new(API_HOST.host, API_HOST.port)
API.use_ssl = true

TOKEN    = ENV['TOKEN']
ROOM_ID  = ENV['ROOM_ID']
BOT_ID   = ENV['BOT_ID']
REDIS    = Redis.new(url: (ENV['REDIS_URL'] || 'redis://localhost:6379'))
LOGGER   = Logger.new(ENV['LOG_FILE'] || STDOUT)
STDOUT.sync = true

http = EM::HttpRequest.new(stream_url(ROOM_ID),
                           keepalive: true,
                           connect_timeout: 0,
                           inactivity_timeout: 0)

EventMachine.run do
  req = http.get(head: authorized_header(TOKEN))

  LOGGER.info 'Connect ' + ROOM_ID + ' with Bot ' + BOT_ID
  req.stream do |chunk|
    next if chunk.strip.empty?

    message = Message.new(JSON.parse(chunk))
    next if message.user.id == BOT_ID

    LOGGER.info 'from:' + message.user.id

    case message
    when Hi  then Hi.call(message)
    when Bye then Bye.call(message)
    end
  end
end
