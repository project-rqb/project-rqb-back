class Api::V1::SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
  end
end
