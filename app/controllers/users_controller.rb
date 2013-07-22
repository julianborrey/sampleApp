class UsersController < ApplicationController
   def show
      @user = User.find(params[:id])
   end
   
   def new
      @user = User.new
   end
   
   def create
      @user = User.new(user_params) #user_params comes from pirvate foo

      if @user.save #if save successful (doesn't return false/nil)
         sign_in @user
         flash[:success] = "Welcome to the Sample App!"
         redirect_to(@user) #not even using "user_url"
      else
         render 'new' #render the new.html.erb template
      end
   end
   
   private
      def user_params #function to throw error if no :user input
                      #but to only give pass on the inputs in permit()
         params.require(:user).permit(:name, :email, :password,
                                      :password_confirmation)
      end
   
end
