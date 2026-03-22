module Api
  module V1
    class TripsController < ApplicationController
      def index
        result = TripsQuery.new(Trip.all, params).call

        render json: {
          data: result[:trips].map { |trip| TripSerializer.serialize(trip) },
          meta: result[:pagination]
        }
      end

      def create
        trip = Trip.new(trip_params)

        if trip.save
          render json: { data: TripSerializer.serialize(trip) }, status: :created
        else
          render json: { error: "Trip fields validation failed", errors: trip.errors.to_hash(true) }, status: :unprocessable_entity
        end
      end

      private

      def trip_params
        params.require(:trip).permit(
          :name,
          :image_url,
          :short_description,
          :long_description,
          :rating
        )
      end

    end
  end
end