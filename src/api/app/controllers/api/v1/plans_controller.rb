module Api
  module V1
    class PlansController < BaseController
      include Authenticatable

      before_action :authenticate_user!
      before_action :set_service
      before_action :set_plan, only: [:show, :update, :destroy]

      # GET /api/v1/services/:service_id/plans
      def index
        @plans = @service.plans
        render json: @plans
      end

      # GET /api/v1/services/:service_id/plans/:id
      def show
        render json: @plan
      end

      # POST /api/v1/services/:service_id/plans
      def create
        @plan = @service.plans.build(plan_params)

        if @plan.save
          render json: @plan, status: :created
        else
          render json: { errors: @plan.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/services/:service_id/plans/:id
      def update
        if @plan.update(plan_params)
          render json: @plan
        else
          render json: { errors: @plan.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/services/:service_id/plans/:id
      def destroy
        @plan.destroy
        head :no_content
      end

      private

      def set_service
        @service = Service.find(params[:service_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'サービスが見つかりません' }, status: :not_found
      end

      def set_plan
        @plan = @service.plans.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'プランが見つかりません' }, status: :not_found
      end

      def plan_params
        params.require(:plan).permit(:plan_name, :price, :currency, :billing_cycle)
      end
    end
  end
end
