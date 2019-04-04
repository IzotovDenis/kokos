class AdminController < ApplicationController
    before_action :authorize
    rescue_from CanCan::AccessDenied do |exception|
        render json: {success: false, error: exception}, status: 400
    end

    def authorize
        if Rails.env.production?
            raise CanCan::AccessDenied unless current_user && current_user.role == 'admin'
        end
    end
end