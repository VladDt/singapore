module Api
	module V1
		class SessionsController < ApplicationController


      def new
        redirect_to root_path if logged_in?
      end

      def create
        @user = User.find_by(email: params[:email])
        if @user && AES.decrypt(@user.encrypted_password, SecretKey.aes_key) == params[:password]# && @user.activated
          log_in(@user)
          params[:remember_me] == '1' ? remember : forget
          create_session_with_key
          redirect_to root_path, status: 201
        else
          render json: { status: 401, message: "Account hasn't been activated or invalid email/password." }
        end
      end

      def destroy
        if logged_in?
          if !cookies[:remember_token]
            @session = current_user.sessions.find_by(key: session[:key])
            @session.destroy
          end
          log_out
        end
        redirect_to '/login', status: 401, message: 'Not authorized'
      end


      private

      def create_session_with_key
        @session = @user.sessions.new     
        @session.key = session[:key]
        @session.save
      end

      def remember
        cookies.signed[:user_id] = { value: session[:user_id], expires: 1.month.from_now.utc }
        cookies[:remember_token] = { value: session[:key], expires: 1.month.from_now.utc }
      end

      def forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
      end


		end
	end
end
