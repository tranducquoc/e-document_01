class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include ApplicationHelper
  include PublicActivity::StoreController
  def default_url_options
    {locale: I18n.locale}
  end

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = t "access_denied"
    redirect_to new_user_session_path
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
