class SessionsController < ApplicationController
  def create
    user = User.find_by name: params[:name]
    if user && user.authenticate(params[:password])
      render json: user
    else
      render json: { error: 'Invalid credentials' },
             status: :unprocessable_entity
    end
  end
end
