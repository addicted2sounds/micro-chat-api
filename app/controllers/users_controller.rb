class UsersController < ApplicationController
  before_action :authenticate!, except: [:create]

  def index
    render json: User.all, each_serializer: UserListSerializer
  end

  def create
    @user = User.new user_params
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
