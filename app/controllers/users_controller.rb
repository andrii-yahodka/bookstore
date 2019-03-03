class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :check_destroy_confirmation, only: :destroy

  def show; end

  def update
    if update_user_data
      flash[:success] = t('message.success.user.update')
      redirect_to root_path and return
    end

    render action: :show
  end

  def destroy
    @user.destroy if flash[:success] = t('message.success.user.destroy')
    
    redirect_to root_path and return
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

  def update_user_data
    user_params[:email].nil? ? @user.update_with_password(user_params) : @user.update(user_params)
  end

  def check_destroy_confirmation
    redirect_to @page_presenter.previous_url and return unless params[:destroy_confirmation]
  end
end
