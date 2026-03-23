class Trips::CalculateAverageRatingJob < ApplicationJob
  queue_as :default

  def perform
    avg_rating = Trip.average(:rating)
    trips_count = Trip.count

    if avg_rating.nil?
      Rails.logger.info("[CalculateAverageRatingJob] No trips found.")
      return
    end

    Rails.logger.info(
      "[CalculateAverageRatingJob] Current average rating is #{avg_rating.to_f.round(2)} across #{trips_count} trips."
    )
  end
end
