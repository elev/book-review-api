class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create

  #sign up
  def create
    user = User.new(user_params)
    if user.save
      json_response(I18n.t('api.v1.sign_up.success'), true, { user: user }, :ok)
    else
      json_response(I18n.t('api.v1.sign_up.wrong'), false, {}, :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params[:user].present?
    json_response(I18n.t('api.v1.sign_up.missing_params'), false, {}, :bad_request)
  end
end