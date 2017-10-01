class ApplicationController < ActionController::API

	helper_method :current_user

  	
    private 
    def current_user      	
      	
      	@user ||= User.find_by(session[:user_id])
      	
     end
      	

    

end
