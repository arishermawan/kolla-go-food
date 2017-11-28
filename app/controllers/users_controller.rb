class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :topup]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def topup

  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if !params[:user][:gopay].nil?
         if params[:user][:gopay].to_i != 0 && !params[:user][:gopay].match(/[^0-9]/)
          params[:user][:gopay] = params[:user][:gopay].to_i + @user.gopay
         end
        if @user.update(gopay_params)
          format.html { redirect_to users_url, notice: 'user was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :topup }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if @user.update(user_params)
          format.html { redirect_to users_url, notice: 'user was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def gopay_params
    params.require(:user).permit(:gopay)
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, role_ids:[])
  end

end
