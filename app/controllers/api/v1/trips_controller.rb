module Api
  module V1
    class TripsController < ApplicationController
      def index
        payload = Rails.cache.fetch(index_page_cache_key, expires_in: 1.minute) do
          result = TripsQuery.new(Trip.all, params).call

          {
            data: result[:trips].map { |trip| TripSummarySerializer.serialize(trip) },
            meta: result[:pagination]
          }
        end

        render json: payload
      end

      def show
        trip = Trip.find(params[:id])

        render json: {
          data: TripDetailSerializer.serialize(trip)
        }
      end

      def create
        trip = Trip.new(trip_params)

        if trip.save
          bump_trips_index_cache

          render json: { data: TripDetailSerializer.serialize(trip) }, status: :created
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

      def index_page_cache_key
        [
          "api/v1/trips/index",
          params[:search].to_s,
          params[:min_rating].to_s,
          params[:sort].to_s,
          params[:order].to_s,
          params[:page].to_s,
          params[:per_page].to_s,
          trips_cache_version
        ].join(":")
      end

      def trips_cache_version
        Rails.cache.fetch("api/v1/trips/cache_version") { 1 }
      end

      def bump_trips_index_cache
        new_version = Rails.cache.increment("api/v1/trips/cache_version", 1, initial: 1)
        Rails.logger.info("[Trips#index] cache version changed to=#{new_version}")
      end

    end
  end
end