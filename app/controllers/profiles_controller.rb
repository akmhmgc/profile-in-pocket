class ProfilesController < ApplicationController
  skip_before_action :check_logged_in, only: :show

  def show
    url_key = params.require(:url_key)
    issued_url = IssuedUrl.find_by(url_key:)
    raise ActiveRecord::RecordNotFound if issued_url.nil?

    session[:url_key] = url_key
    redirect_to login_path and return if issued_url.user.nil?

    user = issued_url.user
    @profile = user.profile
  end
end
