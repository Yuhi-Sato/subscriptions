class ApplicationController < ActionController::API
  include Authenticatable

  # JSONレスポンスのためのデフォルト設定
  before_action :set_default_format

  # 例外ハンドリング
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  def set_default_format
    request.format = :json
  end

  def not_found
    render json: { error: 'リソースが見つかりません' }, status: :not_found
  end

  def bad_request
    render json: { error: 'パラメータが不正です' }, status: :bad_request
  end
end
