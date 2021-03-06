class Public::BaseController < ApplicationController
  layout "public"

  before_action :set_locale

  private

  def set_error_flash(object, error_message)
    if object.valid?
      flash.now[:error] = "Unexpected error: #{error_message}"
    else
      flash.now[:error] = object.errors.messages.values.flatten.join("<br>")
    end
  end

  def set_locale
    requested_locale = params[:locale] || session[:locale] || I18n.default_locale
    locale = FastGettext.set_locale(requested_locale)
    session[:locale] = locale
    I18n.locale = locale
  end
end
