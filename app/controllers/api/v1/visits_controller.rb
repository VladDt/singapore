module Api
  module V1
    class VisitsController < ApplicationController

      before_action :find_visit, only: [:destroy, :update]
      before_action :check_if_doctor


      def create
        @patient_id = User.find_by(phone_number: params[:number]).id
        current_user.patient_visits.create(patient_id: @patient_id, doctor_id: current_user.id,
                                    date_time: params[:datetime], status: 'Future')
      end

      def destroy
        @visit.destroy
      end

      def index
        @visits = Visit.where(doctor_id: current_user.id)
        render json: @visits
      end

      def update
        @visit.update_attributes(visit_update_params)
      end


      private

      def check_if_doctor?
        if !current_user.is_doctor
          redirect_to root_path, message: "You're not allowed"
        end
      end

      def find_visit
        @visit = Visit.find(params[:id])
      end

      def visit_create_params
        params.require(:visit).permit(:date_time)
      end

      def visit_update_params
        params.require(:visit).permit(:date_time, :status)
      end


    end
  end
end
