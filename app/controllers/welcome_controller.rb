class WelcomeController < ApplicationController

    before_action :authorized, except: [:index]

    def index
    end
end
