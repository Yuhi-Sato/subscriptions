module Authenticatable
  extend ActiveSupport::Concern

  included do
    # 現在のユーザーを取得するヘルパーメソッド
    attr_reader :current_user
  end

  # リクエストからFirebaseトークンを検証し、ユーザーを認証する
  def authenticate_user!
    token = extract_token_from_request

    if token.blank?
      render json: { error: '認証トークンが必要です' }, status: :unauthorized
      return false
    end

    begin
      # トークンを検証
      decoded_token = FirebaseIdToken::Signature.verify(token)

      # ユーザーを検索
      uid = decoded_token['sub']
      @current_user = User.find_by(uid: uid)

      if @current_user.nil?
        render json: { error: 'ユーザーが見つかりません' }, status: :unauthorized
        return false
      end

      return true
    rescue => e
      Rails.logger.error "Authentication error: #{e.message}"
      render json: { error: '認証に失敗しました' }, status: :unauthorized
      return false
    end
  end

  private

  # リクエストヘッダーからトークンを抽出
  def extract_token_from_request
    header = request.headers['Authorization']
    header&.split(' ')&.last
  end
end
