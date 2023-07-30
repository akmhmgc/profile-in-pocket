class ProfilesController < ApplicationController
  skip_before_action :check_logged_in, only: :show

  def new
    profile = current_user.profile
    redirect_to edit_profile_path(profile.user.issued_url.url_key) if profile.present?

    @profile = Profile.new
    puts @profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to profile_path(@profile.user.issued_url.url_key)
    else
      render :new
    end
  end

  def show
    url_key = params.require(:url_key)
    issued_url = IssuedUrl.find_by(url_key:)
    raise ActiveRecord::RecordNotFound if issued_url.nil?

    session[:url_key] = url_key
    redirect_to login_path and return if issued_url.user.nil?

    user = issued_url.user
    @profile = user.profile
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :description, :twitter_id, :github_id, :qiita_id, :zenn_id, :qiita_id)
  end
end
