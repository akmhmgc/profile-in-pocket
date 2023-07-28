class ProfilesController < ApplicationController
  skip_before_action :check_logged_in
  def show
    url_key = params.require(:url_key)
    issued_url = IssuedUrl.find_by(url_key:)
    raise ActiveRecord::RecordNotFound if issued_url.nil?

    redirect_to login_path(url_key:) if issued_url.user.nil?
    @user = issued_url.user
  end
end
