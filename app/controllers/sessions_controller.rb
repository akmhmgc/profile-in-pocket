class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: %i[new create]

  def new
    # TODO: ログイン後のページに遷移
    redirect_to root_path if current_user.present?
  end

  def create
    # アカウントを既に持っている場合
    user = User.find_from_auth_hash(auth_hash)
    # TODO: ログイン後のページに遷移
    redirect_to root_path if user.present?

    # 新規作成の場合、profiles/[:url_key]を経由していない場合はエラー
    check_url_key_is_valid
    user.issued_url = @issued_url
    session[:url_key] = nil
    log_in user if user.save
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def check_url_key_is_valid
    url_key = session[:url_key]
    @issued_url = IssuedUrl.find_by(url_key:)
    raise ActiveRecord::RecordNotFound if @issued_url.nil?
  end
end
