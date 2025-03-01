module Api
  module V1
    class AuthController < BaseController
      # POST /api/v1/auth/login
      def login
        # Firebaseトークンの検証
        token = request.headers['Authorization']&.split(' ')&.last

        if token.blank?
          return render json: { error: 'トークンが提供されていません' }, status: :unauthorized
        end

        begin
          # 証明書を更新
          begin
            FirebaseIdToken::Certificates.request
            Rails.logger.info "証明書を更新しました"
          rescue => cert_error
            Rails.logger.error "証明書の更新に失敗しました: #{cert_error.message}"
          end

          # Firebaseトークンを検証
          decoded_token = FirebaseIdToken::Signature.verify(token)

          if decoded_token.nil?
            return render json: { error: 'トークンの検証に失敗しました' }, status: :unauthorized
          end

          # トークンが有効な場合、ユーザー情報を取得
          uid = decoded_token['sub']

          # ユーザーがDBに存在するか確認
          user = User.find_by(uid: uid)

          if user
            # 既存ユーザーの場合はログイン処理
            render json: {
              message: 'ログイン成功',
              user: {
                id: user.id,
                name: user.name,
                email: user.email
              }
            }, status: :ok
          else
            # 新規ユーザーの場合は登録処理
            email = decoded_token['email']
            name = decoded_token['name'] || email.split('@').first

            # 新規ユーザー作成
            user = User.new(
              email: email,
              name: name,
              uid: uid,
              password: SecureRandom.hex(10) # ランダムパスワード生成
            )

            if user.save
              render json: {
                message: '新規ユーザー登録成功',
                user: {
                  id: user.id,
                  name: user.name,
                  email: user.email
                }
              }, status: :created
            else
              render json: { error: user.errors.full_messages }, status: :unprocessable_entity
            end
          end
        rescue => e
          # トークン検証エラー
          Rails.logger.error "認証エラー: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          render json: { error: "認証エラー: #{e.message}" }, status: :unauthorized
        end
      end
    end
  end
end
