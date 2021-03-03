class UsersController < ApplicationController

    before_action :authorized, except: [:create, :login]

    # Create new user
    def create
        user = User.create(user_params)
        if user.valid?
            token = encode_token({user_id: user.id})
            render json: UsersSerializer.new(user, {params: {token: token}}).serialized_json
        else
            # error here should be more meaningful and be either a 400 code
            render json: {error: "Couldn't create user account. Please check the username and password"}, status: 401
        end
    end

    # Logging in

    def login
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            token = encode_token({user_id: user.id})
            render json: UsersSerializer.new(user, {params: {token: token}}).serialized_json
        else
            # error here should be more meaningful and be either a 400 code
            render json: {error: "Invalid username or password. Please check and try again"}, status: 404
        end
    end

    # auth based on JWT

    private

    def user_params
        params.permit(
            :username, 
            :password,  
            :first_name, 
            :last_name, 
            :mobile_number, 
            :email_address
            )
    end

end
