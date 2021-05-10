module ExtractToken
  extend self

  def extracted_token(token)
    JwtEncoder.decode(token)
  rescue
    {}
  end
end
