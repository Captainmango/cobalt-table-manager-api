class WelcomeController < ApplicationController

    before_action :authorized, except: [:index]

    def index
        render "index"
    end
end
