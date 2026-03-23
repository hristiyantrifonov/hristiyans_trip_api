require "rails_helper"

RSpec.describe Trips::CalculateAverageRatingJob, type: :job do
  describe "#perform" do
    before do
      allow(Rails.logger).to receive(:info)
    end

    context "when there are no trips" do
      it "logs that no trips were found" do
        described_class.perform_now

        expect(Rails.logger).to have_received(:info)
                                  .with("[CalculateAverageRatingJob] No trips found.")
      end
    end

    context "when trips exist" do
      it "log the correct average rating" do
        Trip.create!(name: "Trip with a 4 rating", rating: 4)
        Trip.create!(name: "Trip with a 2 rating", rating: 2)
        Trip.create!(name: "Trip with a 5 rating", rating: 5)

        described_class.perform_now

        expect(Rails.logger).to have_received(:info)
                                  .with("[CalculateAverageRatingJob] Current average rating is 3.67 across 3 trips.")
      end
    end
  end
end