class TripDetailSerializer
  def self.serialize(trip)
    {
      id: trip.id,
      name: trip.name,
      image_url: trip.image_url,
      short_description: trip.short_description,
      long_description: trip.long_description,
      rating: trip.rating,
      last_updated_at: trip.updated_at,
    }
  end
end