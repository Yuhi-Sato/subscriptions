module Api
  module V1
    class BaseController < ApplicationController
      # APIバージョン1のベースコントローラー
      # 共通の処理や設定をここに記述します

      before_action :set_default_format

      private

      def set_default_format
        request.format = :json
      end
    end
  end
end
