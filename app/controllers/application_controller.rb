class ApplicationController < ActionController::Base
include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def after_sign_in_path_for(resource)
    root_path
  end

  helper_method :cart_item_count

  private

  def cart_item_count
    (session[:cart] || []).size
  end

  def user_not_authorized
    redirect_back fallback_location: root_path, alert: "Tu n'as pas les droits pour effectuer cette action."
  end
end
