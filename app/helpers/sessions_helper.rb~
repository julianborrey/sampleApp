module SessionsHelper
   
   #one token for cookies, then the encrypted one for the data base.
   def sign_in(user)
      remember_token = User.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.encrypt(remember_token))
      self.current_user = user
   end

   def signed_in?
      !(current_user.nil?)
   end

   def current_user=(user)
      @current_user = user
   end

   def current_user
      remember_token  = User.encrypt(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
   end

   def current_user?(user)
      user == current_user
   end

   def sign_out
      self.current_user = nil
      cookies.delete(:remember_token)
   end
   
   def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      clear_return_to
   end
   
   private

      def store_location
         session[:return_to] = request.url
      end

      def clear_return_to
         session[:return_to] = nil
      end
end
