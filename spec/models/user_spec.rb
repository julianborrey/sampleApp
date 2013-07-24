require 'spec_helper'

describe User do
   #before we run a certain function, in this case the constructor
   before { @user = User.new(name: "Example User", email: "user@example.com",
                             password: "foobar", password_confirmation: "foobar") }
   
   #make the user object the subject of the following test
   subject { @user }
   
   #do some testing. Just checks that these fields exist.
   it { should respond_to(:name)                  }
   it { should respond_to(:email)                 }
   it { should respond_to(:password_digest)       }
   it { should respond_to(:password)              }
   it { should respond_to(:password_confirmation) }
   it { should respond_to(:authenticate)          }
   it { should respond_to(:remember_token)        }
   it { should respond_to(:admin)                 }

   ###Note: we could have used the RSpec code to do the same tests
   #it "should have field 'name'" do
   #   expect(@user).to respond_to(:name)
   #end
   
   it {should be_valid } #checks the data input is valid 
   it {should_not be_admin } #by default is not admin
   
   describe "with admin attribute set to 'true'" do
      before do
         @user.save!
         @user.toggle!(:admin)
      end

      it { should be_admin }
   end
   
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
   
   #ensure that the email is entered into the db with all lowercase
   describe "email address with mixed case" do
      let(:mixed_case_email) { "Foo@ExamPle.CoM" }

      it "should be all saved as lower case" do
         @user.email = mixed_case_email
         @user.save
         expect(@user.reload.email).to eq mixed_case_email.downcase
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
   
   ## Password Checks
   #check for blank password
   describe "when password is not present" do
      before do
         @user = User.new(name: "Example User", email: "user@example.com",
                          password: " ", password_confirmation: " ")
      end
      it { should_not be_valid }
   end
   
   #check for password length (min of 6 chars)
   describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
   end
   
   #check for password mismatch
   describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
   end

   ### Authentication Checks ###
   describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }
      
      describe "with valid password" do
         it { should eq found_user.authenticate(@user.password) }
      end
      
      describe "with invalid password" do
         #using some string ("invalid") which is not the password
         let(:user_for_invalid_password) { found_user.authenticate("invalid") }
         
         it { should_not eq user_for_invalid_password }
         specify { expect(user_for_invalid_password).to be_false }
      end
   end

   describe "remember token" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
   end
end
