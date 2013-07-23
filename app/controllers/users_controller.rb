class UsersController < ApplicationController
   before_action :signed_in_user, only: [:index, :edit, :update]
   before_action :correct_user, only: [:edit, :update]
   
   def index
      @users = User.paginate(page: params[:page])
   end

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

   def edit
     #@user = User.find(params[:id])
   end

   def update
      #@user = User.find(params[:id])
      if @user.update_attributes(user_params)
         #handle a successful update
         flash[:success] = "Profile updated"
         sign_in @user
         redirect_to @user
      else
         render 'edit';
      end
   end
   
   private
      def user_params #function to throw error if no :user input
                      #but to only give pass on the inputs in permit()
         params.require(:user).permit(:name, :email, :password,
                                      :password_confirmation)
      end

      ### before filters ###

      def signed_in_user
         store_location
         redirect_to signin_url, notice: "Please sign in." unless signed_in?
         #we are adding an option to the redirect_to function which is a hash
         #it updates the flash[] hash
      end
      
      def correct_user
         @user = User.find(params[:id])
         redirect_to(root_path) unless current_user?(@user)
      end
end
