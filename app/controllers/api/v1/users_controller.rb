module Api
	module V1
		class UsersController < ApplicationController

      before_action :find_user, only: [:show, :edit, :update, :destroy, 
                                      :accept_doctor_approval, :deny_doctor_approval]


			def index
        @users = User.where(is_doctor: true, deleted: false).order(name: :asc)
      end

      def new
        redirect_to root_path if logged_in?
      end

      def create
        @user = User.new(user_params)
        @user.encrypted_password = AES.encrypt(params[:user][:password], SecretKey.aes_key)
        need_approval(@user) if params[:user][:certificate]
        if @user.save
          @user.locations.create(latitude: params[:user][:latitude], longitude: params[:user][:longitude])
          #@user.send_activation_email
          redirect_to '/api/v1/login', status: 200, message: 'Please check your email to activate your account'
        else
          render json: { status: 449, message: 'Retry with' }
        end
      end

      def show
        render json: @user
      end

      def edit
        render json: @user
      end

      def update
        if params[:user][:password] && params[:user][:password].size < 6
          render json: { status: 302, message: 'Passwd should be at least 6 symbols' }
        elsif !@user.is_doctor && params[:user][:certificate]
          edit_user(@user) { @user.sessions.delete_all && log_out }
        else
          edit_user(@user)
        end
      end

      def destroy
        @user.update_attribute(:deleted, true)
        log_out if @user == current_user
        redirect_to '/users', status: 200, message: 'Successfully deleted'
      end

      def accept_doctor_approval
        @user.update_attribute(need_admin_approval: false, is_doctor: true)
        render json: { status: 200, message: 'accepted' }
      end

      def deny_doctor_approval
        @user.update_attribute(need_admin_approval: false)
        render json: { status: 200, message: 'accepted' }
      end


      private

      def edit_user(user)
        user.update_attributes(user_params)
        yield
        user.errors.empty? ? (render json: user) : user.errors
      end

      def find_user
        @user = User.find(params[:id])
      end

      def need_approval(user)
        user.need_admin_approval = true
        SendSmsService.new(user.phone_number).call
      end

      def user_params
        params.require(:user).permit(:full_name, :email, :encrypted_password, :avatar,
                                    :phone_number, :certificate, :description,
                                    location_attributes: [:longitude, :latitude])
      end



		end
	end
end
