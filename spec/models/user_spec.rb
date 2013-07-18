require 'spec_helper'

describe User do
   #before we run a certain function, in this case the constructor
   before { @user = User.new(name: "Example User", email: "user@example.com") }
   
   #make the user object the subject of the following test
   subject { @user }
   
   #do some testing. Just checks that these fields exist.
   it { should respond_to(:name)  }
   it { should respond_to(:email) }
   
   ###Note: we could have used the RSpec code to do the same tests
   #it "should have field 'name'" do
   #   expect(@user).to respond_to(:name)
   #end
   
   it {should be_valid } #checks the data input is valid 
   
   ### Check that validation functions are working ###
   ## Name validations
   #check for the name
   describe "when name is not present" do
      before { @user.name = "" } #oddly, " " is a blank string...
      it { should_not be_valid }
   end 
   
   #check for max length of 40 for name string
   describe "when name is too long" do
      before { @user.name = "a" * 41 }
      it { should_not be_valid }
   end
   

   ## E-mail validation
   #check for checking for email being blank
   describe "when email is not present" do
      before { @user.email = "" }
      it { should_not be_valid }
   end
   
   #check invalid  E-mail formats
   describe "when email format is invalid" do
      it "should be invalid" do
         addresses = %w[user@foo,com user_at_foo.com example.user@foo. 
                        foo@bar_baz.com foo@bar+baz.com] #example invalids
         
         addresses.each do |invalid_address| #check each one
            @user.email = invalid_address
            expect(@user).not_to be_valid
         end
      end
   end

   #check valid E-mail formats
   describe "when email format is valid" do
      it "should be valid" do
         addresses = %w[user@foo.com USER@FOO.com A_US-er@foo.bar.com 
                        first.last@foo.jp a+b@foo.cn] #example valids
   
         addresses.each do |valid_address| #check each one
            @user.email = valid_address
            expect(@user).to be_valid
         end
      end
   end
   
   #check test for ensuring the submitted email is unique
   describe "when email address is already taken" do
      before do
         user_with_same_email = @user.dup #make a duplicate profile
         user_with_same_email.email = @user.email.upcase 
         #also get a different case of email to original
         
         user_with_same_email.save #try to put them into the db
      end                          #which should trigger the error
      
      it { should_not be_valid }
   end

end
