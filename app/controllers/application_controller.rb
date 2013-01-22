class ApplicationController < ActionController::Base
  before_filter :set_locale
  
  protect_from_forgery  
  # respond_to_mobile_requests :skip_xhr_requests => false, :fall_back => :html
  
  def set_locale
    I18n.locale = request.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end

  def current_user?(user)
    current_user == user
  end
end
