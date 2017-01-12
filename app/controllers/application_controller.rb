class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = t "access_denied"
    redirect_to root_path
  end

  def verify_user
    unless user_signed_in?
      flash[:danger] = t ".please_log_in"
      redirect_to new_user_session_path
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  private
  def namespace
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end
end
