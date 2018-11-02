class LoginController < ApplicationController

    def sign_in
        render json: {success: true, token: '123s2323'}
    end

end
