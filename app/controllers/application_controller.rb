class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    rescue_from CanCan::AccessDenied do |exception|
        render json: {success: false, error: exception}, status: 400
    end

    def current_user
        @current_user ||= AuthorizeApiRequest.call(params[:token]).result
    end


end
