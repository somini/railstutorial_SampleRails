module UsersHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.mail.downcase)
    return "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
