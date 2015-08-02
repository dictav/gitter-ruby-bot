require './user'
require './message'

def stream_url(room_id)
  "https://stream.gitter.im/v1/rooms/#{room_id}/chatMessages"
end

def post_path(room_id)
  "/v1/rooms/#{room_id}/chatMessages"
end

def authorized_header(token, opts = {})
  {
    'Authorization' => "Bearer #{token}",
    'accept' => 'application/json'
  }.merge(opts)
end
