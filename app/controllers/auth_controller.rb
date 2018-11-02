class AuthController < ApplicationController

    def sign_in
        user = AuthenticateUser.call(params[:email], params[:password])
        if user.result 
            render json: {success: true, token: user.result}
        else
            render json: {success: false, errors: user.errors}
        end

    end

end