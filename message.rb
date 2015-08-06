class Message
  attr_reader :id,
              :text,
              :html,
              :sent,
              :edited_at,
              :user,
              :unread,
              :read_by,
              :urls,
              :mentions,
              :issues,
              :meta,
              :v

  def initialize(src)
    fail ArgumentError unless src.is_a? Hash
    @id        = src['id']
    @text      = src['text']
    @html      = src['html']
    @sent      = src['sent']
    @edited_at = src['editedAt']
    @user      = User.new(src['fromUser'])
    @unread    = src['unread']
    @read_by   = src['readBy']
    @urls      = src['urls']
    @mentions  = src['mentions']
    @issues    = src['issues']
    @meta      = src['meta']
    @v         = src['v']

    LOGGER.debug(self)
  end

  def ===(other)
    case other
    when self then true
    else
      false
    end
  end
end
