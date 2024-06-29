class Api::V1::BasesController < ApplicationController
  def index
    tasks = Task.all
    render json: tasks, status: :ok
  end
end
