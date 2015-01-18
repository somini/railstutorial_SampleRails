module UsersHelper
  def gravatar_url(user,options = { size: 100, default: "mm",rating: "pg" })
    gravatar_id = Digest::MD5::hexdigest(user.mail.downcase)
    size = options[:size] # 1px - 2048px
    default = options[:default] # 404,mm,identicon,monsterid,wavatar,retro,blank
    rating = options[:rating] # g,pg,r,x
    # http://en.gravatar.com/site/implement/images/
    return "https://secure.gravatar.com/avatar/#{gravatar_id}?d=#{default}&size=#{size}&rating=#{rating}"
  end

  def gravatar_for(user, options = {size: 100, default: "mm", rating: "pg"} )
    image_tag(gravatar_url(user), alt: user.nick, class: "gravatar")
  end
end
