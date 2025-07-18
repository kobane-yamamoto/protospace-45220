class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, # 新規登録時
      keys: [:name, :profile, :occupation, :position]
    )
  end
end