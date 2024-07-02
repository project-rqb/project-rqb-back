class Api::V1::BasesController < ApplicationController
  def index
    render json: { message: 'GoodBay, World!' }
  end
end
