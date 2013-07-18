module UserHelper
   #Using Gravatar means we need to get the profile picture via a 
   #URL which corresponds to the correct email address.
   #The hash which references the email address is formed by "hexdigest"
   
   def gravatar_for(user)
      gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
   end
   
end
