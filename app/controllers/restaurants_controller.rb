class RestaurantsController < ApplicationController

    def index
        restaurants = Restaurant.all
        render json: RestaurantsSerializer.new(restaurants).serialized_json
    end

    def get_by_search_term
        search_term = search_params[:search_term]

        begin
            restaurants = Restaurant.where("name LIKE '%#{search_term}%'")
                      .or(Restaurant.where("address LIKE '%#{search_term}%'"))
                      .or(Restaurant.where("name LIKE '%#{search_term.capitalize}%'"))
                      .or(Restaurant.where("address LIKE '%#{search_term.capitalize}%'"))
        rescue
            render json: {message: "Couldn't find restaurants by what you searched. Please try again"}, status: 404
        else
            render json: RestaurantsSerializer.new(restaurants).serialized_json
        end
    end

    private

    def search_params
        params.permit(:search_term, :restaurant)
    end

    # def restaurant_params
    #     params.permit()
    # end

end
