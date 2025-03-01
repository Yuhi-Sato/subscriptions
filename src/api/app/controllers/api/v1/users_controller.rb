module Api
  module V1
    class UsersController < BaseController
      before_action :authenticate_user!

      # GET /api/v1/users/me
      # 現在のユーザー情報を取得
      def me
        render json: {
          user: {
            id: current_user.id,
            name: current_user.name,
            email: current_user.email,
            created_at: current_user.created_at
          }
        }, status: :ok
      end

      # PUT /api/v1/users/me
      # 現在のユーザー情報を更新
      def update
        if current_user.update(user_params)
          render json: {
            message: 'ユーザー情報を更新しました',
            user: {
              id: current_user.id,
              name: current_user.name,
              email: current_user.email
            }
          }, status: :ok
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email)
      end
    end
  end
end
