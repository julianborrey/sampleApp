class User < ActiveRecord::Base
   #ensure that we are going to input an all lowercase email (helps with uniqueness check)
   before_save { self.email = email.downcase }

   validates :name,  presence: true, length: { maximum: 40 } #just a function validates(:name, presece: true);
   
   #make a REGex
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }
                     #put uniqueness check on db as well to prevent double submit error
end
