class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    skip_before_action :verify_authenticity_token

    def login!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end

    def current_user
        User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end
end
