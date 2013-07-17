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
end
