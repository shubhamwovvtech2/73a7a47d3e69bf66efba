class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name])
  end

  def after_sign_in_path_for(user)
	 if user.present?
	  	homes_path
	 else
		 new_user_session_path
	 end
  end 

end
