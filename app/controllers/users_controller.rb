class UsersController < ApplicationController
  before_action :check_if_admin, :only => [:index]
  include MonstersHelper

  def index
      @users = User.all
  end

  def show
    
    @user = User.find params[:id]
    @player_spells = how_manyspells
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new   #returns back to sign up page with details
    end
  end

  def edit
    @user = @current_user
    render :new
  end

  def update
    user = @current_user    #only upate current user
    user.update user_params
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :image)
  end

  def check_if_admin
    redirect_to root_path unless @current_user.present? && @current_user.admin?
  end

end
