class SessionsController < ApplicationController
    def new
        # debugger
        @user = User.new
        render :new 
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user 
            login!(@user)
            redirect_to user_url
        else
            @user = User.new(email: params[:user][:email])
            render :new 
        end
    end

    def destroy
        @user = current_user 
        if @user
            current_user.reset_session_token!
            session[:session_token] = nil 
        end
        redirect_to new_session_url
    end
end
