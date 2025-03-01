require 'firebase_id_token'
require 'redis'

# FirebaseプロジェクトのプロジェクトID
# 本番環境では環境変数から取得することをお勧めします
FIREBASE_PROJECT_ID = ENV['FIREBASE_PROJECT_ID'] || 'your-firebase-project-id'

# Redisの設定
redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379/0'
redis = Redis.new(url: redis_url)

# キャッシュの設定
FirebaseIdToken.configure do |config|
  # Redisインスタンスを設定
  config.redis = redis
  config.project_ids = [FIREBASE_PROJECT_ID]
end

# 証明書を事前に取得
# アプリケーション起動時に証明書を取得しておく
begin
  FirebaseIdToken::Certificates.request
rescue => e
  Rails.logger.error "Failed to fetch Firebase certificates: #{e.message}"
end
