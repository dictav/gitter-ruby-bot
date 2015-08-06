class User
  attr_reader :id,
              :username,
              :display_name,
              :url,
              :avatar_url_small,
              :avatar_url_medium
  def initialize(src)
    fail ArgumentError unless src.is_a? Hash
    @id                = src['id']
    @username          = src['username']
    @display_name      = src['displayName']
    @url               = src['url']
    @avatar_url_small  = src['avatarUrlSmall']
    @avatar_url_medium = src['avatarUrlMedium']

    LOGGER.debug(self)
  end
end
