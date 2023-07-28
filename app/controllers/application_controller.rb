class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :check_logged_in

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound,     with: :handle_404
    rescue_from ActionController::RoutingError,   with: :handle_404
    rescue_from ActionController::InvalidAuthenticityToken, with: :handle_404
  end

  def handle_404(e = nil)
    logger.info { "Rendering 404 with exception: #{[e.inspect, *e.backtrace[0..4]].join("\n")},\nRequestPath: #{request.path}" } if e
    if request.format.to_sym == :json
      render json: { error: '404 error' }, status: :not_found
    else
      render file: Rails.root.join('public/404.html'), status: :not_found, layout: false, content_type: 'text/html'
    end
  end

  def check_logged_in
    return if current_user

    redirect_to root_path
  end
end
