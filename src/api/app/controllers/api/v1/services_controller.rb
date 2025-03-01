module Api
  module V1
    class ServicesController < BaseController
      include Authenticatable

      before_action :authenticate_user!
      before_action :set_service, only: [:show, :update, :destroy]

      # GET /api/v1/services
      def index
        @services = Service.all
        render json: @services
      end

      # GET /api/v1/services/:id
      def show
        render json: @service
      end

      # POST /api/v1/services
      def create
        @service = Service.new(service_params)

        if @service.save
          render json: @service, status: :created
        else
          render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/services/:id
      def update
        if @service.update(service_params)
          render json: @service
        else
          render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/services/:id
      def destroy
        @service.destroy
        head :no_content
      end

      private

      def set_service
        @service = Service.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'サービスが見つかりません' }, status: :not_found
      end

      def service_params
        params.require(:service).permit(:service_name, :category, :official_url)
      end
    end
  end
end
