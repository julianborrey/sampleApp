# example_user.rb
# by Julian Borrey
# 14/07/2013
# 
# Class for sampleApp which supports the user model.

class User
   #makes assets which we can automatically use get() and set() on
   attr_accessor(:name, :email);
   
   #the constructor is called when we do .new()
   #there is a default input to the function given no args
   def initialize(attributes = {})
      @name  = attributes[:name];
      @email = attributes[:email];
      return;
   end
   #@foo is a instance variable (PUBLIC!)
   
   def formatted_email
      return "#{@name} <#{@email}>";
   end
end
