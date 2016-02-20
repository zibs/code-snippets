class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session simply checks for the user.ID in the current session?
      # session[:user_id] = @user.id
      sign_in(@user)
      redirect_to(root_path, flash: { success: "User Created!"})
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, flash: {success: "Information Renewed..."}
    else
      render :edit
    end
  end

  def destroy
  end

    private

      def user_params
        params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation])
      end

      def find_user
        @user = User.find(params[:id])
      end

end
