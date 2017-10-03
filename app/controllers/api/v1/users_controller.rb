class Api::V1::UsersController < ApplicationController

  before_action :current_user
  def index
    @users = User.all
    render 'users/users.json.jbuilder', users: @users
  end

  def create
    
    @user = User.new(user_params)

    if @user.save
      render 'users/user.json.jbuilder', users: @users
    else
      
      render json: {
        errors: @user.errors.full_Messages
      }, status: 500
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render 'users/user.json.jbuilder', user: @user
    else
      render json: {
        errors: [
          {message: "Page not found"}
        ]
      }, status: 404
    end

  end

  def login
    
    @user = User.find_by(username: params[:user][:username])

    if !@user
      render json: {
        errors: {
          username: ["Unable to find a user with the provided username"]
        }
      }, status: 500
      elsif @user
        render 'users/user.json.jbuilder', user: @user
      end
  end

   def current
     
     @user = current_user

     render 'users/user.json.jbuilder', user: @user


   end

  private

    def user_params
      
      params.require(:user).permit(:username)

    end



end
