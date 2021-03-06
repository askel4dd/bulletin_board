class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :login, :fname, :lname, :birthday, :address, :city, :zip, :state, :country, :uid, :provider, :latitude, :longitude) }
    end
end
