class SessionsController < ApplicationController

 def create
     user = User.find_by(email: params[:session][:email])
     if user && user.authenticate(params[:session][:password])
       sign_in(user)
       redirect_to root_path, notice: "Signed in!"
     else
       flash[:alert] = "Invalid email/password combination"
       render :new
     end
   end

   def destroy
     session[:user_id] = nil
     redirect_to root_path
   end

end
