module Api
  module V1
    class SubscriptionsController < BaseController
      include Authenticatable

      before_action :authenticate_user!
      before_action :set_subscription, only: [:show, :update, :destroy]

      # GET /api/v1/subscriptions
      def index
        @subscriptions = current_user.subscriptions.includes(plan: :service)
        render json: @subscriptions, include: { plan: { include: :service } }
      end

      # GET /api/v1/subscriptions/:id
      def show
        render json: @subscription, include: { plan: { include: :service } }
      end

      # POST /api/v1/subscriptions
      def create
        @subscription = current_user.subscriptions.build(subscription_params)

        if @subscription.save
          render json: @subscription, status: :created, include: { plan: { include: :service } }
        else
          render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/subscriptions/:id
      def update
        if @subscription.update(subscription_params)
          render json: @subscription, include: { plan: { include: :service } }
        else
          render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/subscriptions/:id
      def destroy
        @subscription.destroy
        head :no_content
      end

      private

      def set_subscription
        @subscription = current_user.subscriptions.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'サブスクリプションが見つかりません' }, status: :not_found
      end

      def subscription_params
        params.require(:subscription).permit(:plan_id, :start_at, :end_at, :next_payment_date, :memo)
      end
    end
  end
end
