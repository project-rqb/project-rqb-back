module UuidSetter
  def short_uuid
    Base64.urlsafe_encode64([uuid.delete('-')].pack('H*')).tr('=', '')
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
