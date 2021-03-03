class ReservationsController < ApplicationController

    before_action :find_user
    before_action :find_reservation, only: [:show, :update]

    def index
        reservations = @user.reservations
        render json: ReservationsSerializer.new(reservations).serialized_json
    end

    def create
        begin
            restaurant = Restaurant.find_by(id: reservation_params[:restaurant_id])
            reservation = @user.reservations.create(reservation_params.except(:restaurant_id))
            reservation.restaurant_id = restaurant.id
            reservation.save
        rescue
            render json: {message: "Unable to create booking, please check details and try again"}, status: 401
        else
            send_message(@user.mobile_number, "You've created a booking at #{restaurant.name} to start at #{reservation.time}. We look forward to seeing you :)")
            render json: ReservationsSerializer.new(reservation).serialized_json
        end
    end

    def show
        render json: ReservationsSerializer.new(@reservation).serialized_json
    end

    def update
        @reservation.update(time: reservation_params[:time], diners: reservation_params[:diners], rating: reservation_params[:rating])
        render json: ReservationsSerializer.new(@reservation).serialized_json
    end
    

    private

    def send_message(phone_number, alert_message)
        @twilio_number = ENV['TWIL_NUMBER']
        @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
            
            message = @client.messages.create(
              :from => @twilio_number,
              :to => phone_number,
              :body => alert_message,
            )
    end

    def find_user
        @user = User.find_by(id: reservation_params[:user_id])
    end

    def find_reservation
        @reservation = Reservation.find_by(id: reservation_params[:reservation_id])
    end

    def reservation_params
        params.permit(:user_id,
                      :reservation_id,
                      :restaurant_id,
                      :time,
                      :diners,
                      :rating
                     )
    end

end
