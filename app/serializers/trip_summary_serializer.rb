class TripSummarySerializer
  def self.serialize(trip)
    {
      id: trip.id,
      name: trip.name,
      image_url: trip.image_url,
      short_description: trip.short_description,
      rating: trip.rating
    }
  end
end