class Api::V1::BasesController < ApplicationController
  def index
    # NOTE : 確認用なので削除してよいです
    render json: { message: 'Hello World' }
  end
end
