require "rails_helper"

RSpec.describe Trip, type: :model do
  describe "validations" do
    context "name" do
      it "is invalid without a name" do
        trip = described_class.new(name: nil, rating: 4)
        expect(trip).not_to be_valid
        expect(trip.errors[:name]).to include("can't be blank")
      end

      it "is valid with a name" do
        trip = described_class.new(name: "Grand Canyon", rating: 5)
        expect(trip).to be_valid
      end
    end

    context "rating" do
      it "is invalid without a rating" do
        trip = described_class.new(name: "Test Trip", rating: nil)
        expect(trip).not_to be_valid
        expect(trip.errors[:rating]).to include("can't be blank")
      end

      it "is invalid when rating is less than 1" do
        trip = described_class.new(name: "Test Trip", rating: 0)
        expect(trip).not_to be_valid
        expect(trip.errors[:rating]).to include("must be greater than or equal to 1")
      end

      it "is invalid when rating is greater than 5" do
        trip = described_class.new(name: "Test Trip", rating: 6)
        expect(trip).not_to be_valid
        expect(trip.errors[:rating]).to include("must be less than or equal to 5")
      end

      it "is invalid when rating is not an integer" do
        trip = described_class.new(name: "Test Trip", rating: 3.5)
        expect(trip).not_to be_valid
        expect(trip.errors[:rating]).to include("must be an integer")
      end

      it "is valid with rating of 1" do
        trip = described_class.new(name: "Bad Trip", rating: 1)
        expect(trip).to be_valid
      end

      it "is valid with rating of 5" do
        trip = described_class.new(name: "Great Trip", rating: 5)
        expect(trip).to be_valid
      end
    end

    context "image_url" do
      it "is valid with a proper http URL" do
        trip = described_class.new(name: "Test Trip", rating: 4, image_url: "http://example.com/image.jpg")
        expect(trip).to be_valid
      end

      it "is valid with a proper https URL" do
        trip = described_class.new(name: "Test Trip", rating: 4, image_url: "https://example.com/image.jpg")
        expect(trip).to be_valid
      end

      it "is valid when nil" do
        trip = described_class.new(name: "Test Trip", rating: 4, image_url: nil)
        expect(trip).to be_valid
      end

      it "is invalid with an invalid URL format" do
        trip = described_class.new(name: "Test Trip", rating: 4, image_url: "not-a-url")
        expect(trip).not_to be_valid
        expect(trip.errors[:image_url]).to include("is invalid")
      end

    end
  end
end
