class SessionsController < ApplicationController
  def create
    user = User.find_by name: user_params[:name]
    if user && user.authenticate(user_params[:password])
      render json: user
    else
      render json: { error: 'Invalid credentials' },
             status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
