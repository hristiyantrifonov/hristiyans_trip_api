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
    end
  end
end