require "rails_helper"

RSpec.describe "Api::V1::Trips", type: :request do
  let(:base_url) { "/api/v1/trips" }

  before(:each) do
    Rails.cache.clear
  end

  describe "GET /api/v1/trips" do
    let!(:trips) { create_list(:trip, 15) }

    context "when listing trips" do
      it "returns a successful response" do
        get base_url
        expect(response).to have_http_status(:ok)
      end

      it "returns trips in the expected format" do
        get base_url
        json = response.parsed_body

        expect(json).to have_key("data")
        expect(json).to have_key("meta")
        expect(json["data"]).to be_an(Array)
      end

      it "includes the correct trip attributes in summary" do
        get base_url
        json = response.parsed_body

        trip_data = json["data"].first
        expect(trip_data.keys).to match_array(%w[id name image_url short_description rating])
        expect(trip_data).not_to have_key("long_description")
        expect(trip_data).not_to have_key("last_updated_at")
      end

      it "returns paginated results by default" do
        get base_url
        json = response.parsed_body

        expect(json["meta"]["per_page"]).to eq(10)
        expect(json["data"].length).to eq(10)
        expect(json["meta"]["total_trips"]).to eq(15)
        expect(json["meta"]["total_pages"]).to eq(2)
        expect(json["meta"]["current_page"]).to eq(1)
      end
    end

    context "when searching" do
      let!(:matching_trip) { create(:trip, name: "Grand Canyon Adventure") }
      let!(:non_matching_trip) { create(:trip, name: "City Museum") }

      it "filters trips by search term in name" do
        get "#{base_url}?search=Grand"
        json = response.parsed_body

        expect(json["data"].length).to eq(1)
        expect(json["data"].first["name"]).to include("Grand")
      end

      it "filters trips by search term in short_description" do
        matching_trip.update!(short_description: "Mountain hiking experience")

        get "#{base_url}?search=hiking"
        json = response.parsed_body

        expect(json["data"].length).to eq(1)
        expect(json["data"].first["short_description"]).to include("hiking")
      end

      it "filters trips by search term in long_description" do
        matching_trip.update!(long_description: "Beautiful desert landscapes")

        get "#{base_url}?search=desert"
        json = response.parsed_body

        expect(json["data"].length).to eq(1)
      end

      it "search is case insensitive" do
        get "#{base_url}?search=GRAND"
        json = response.parsed_body

        expect(json["data"].length).to eq(1)
      end

      it "returns empty results when no match" do
        get "#{base_url}?search=nonexistent"
        json = response.parsed_body

        expect(json["data"]).to be_empty
        expect(json["meta"]["total_trips"]).to eq(0)
      end
    end

    context "when filtering" do
      let!(:one_star) { create(:trip, rating: 1) }
      let!(:three_star) { create(:trip, rating: 3) }
      let!(:five_star) { create(:trip, rating: 5) }

      it "filters by minimum rating" do
        get "#{base_url}?min_rating=4&per_page=100"
        json = response.parsed_body

        returned_ids = json["data"].map { |t| t["id"] }
        expect(returned_ids).to include(five_star.id)
        expect(returned_ids).not_to include(one_star.id)
        expect(returned_ids).not_to include(three_star.id)
      end

      it "includes trips with rating equal to min_rating" do
        get "#{base_url}?min_rating=3&per_page=100"
        json = response.parsed_body

        returned_ids = json["data"].map { |t| t["id"] }
        expect(returned_ids).to include(three_star.id)
        expect(returned_ids).to include(five_star.id)
      end

      it "returns empty when min_rating is out of valid range" do
        get "#{base_url}?min_rating=0&per_page=100"
        json = response.parsed_body

        expect(json["data"]).to be_empty
      end

      it "returns empty when min_rating exceeds 5" do
        get "#{base_url}?min_rating=6&per_page=100"
        json = response.parsed_body

        expect(json["data"]).to be_empty
      end
    end

    context "when sorting" do
      let!(:trip_a) { create(:trip, name: "Alpha Place", rating: 2) }
      let!(:trip_z) { create(:trip, name: "Zebra Zone", rating: 4) }
      let!(:trip_m) { create(:trip, name: "Middle Ground", rating: 3) }

      it "sorts by name ascending by default" do
        get base_url
        json = response.parsed_body

        test_trip_names = [trip_a.name, trip_m.name, trip_z.name]
        returned_test_trips = json["data"].select { |t| test_trip_names.include?(t["name"]) }
        names = returned_test_trips.map { |t| t["name"] }
        expect(names).to eq(names.sort)
      end

      it "sorts by rating ascending" do
        get "#{base_url}?sort=rating&order=asc"
        json = response.parsed_body

        test_trip_names = [trip_a.name, trip_m.name, trip_z.name]
        returned_test_trips = json["data"].select { |t| test_trip_names.include?(t["name"]) }
        ratings = returned_test_trips.map { |t| t["rating"] }
        expect(ratings).to eq(ratings.sort)
      end

      it "sorts by rating descending" do
        get "#{base_url}?sort=rating&order=desc"
        json = response.parsed_body

        test_trip_names = [trip_a.name, trip_m.name, trip_z.name]
        returned_test_trips = json["data"].select { |t| test_trip_names.include?(t["name"]) }
        ratings = returned_test_trips.map { |t| t["rating"] }
        expect(ratings).to eq(ratings.sort.reverse)
      end

      it "falls back to default order for invalid sort direction" do
        get "#{base_url}?sort=name&order=invalid"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when paginating" do
      let!(:trips) { create_list(:trip, 25) }

      it "respects custom per_page parameter" do
        get "#{base_url}?per_page=5"
        json = response.parsed_body

        expect(json["data"].length).to eq(5)
        expect(json["meta"]["per_page"]).to eq(5)
        expect(json["meta"]["total_pages"]).to eq(5)
      end

      it "limits per_page to maximum of 20" do
        get "#{base_url}?per_page=100"
        json = response.parsed_body

        expect(json["meta"]["per_page"]).to eq(20)
      end

      it "returns correct page of results" do
        get "#{base_url}?page=2&per_page=5"
        json = response.parsed_body

        expect(json["meta"]["current_page"]).to eq(2)
        expect(json["data"].length).to eq(5)
      end

      it "returns empty when page exceeds total pages" do
        get "#{base_url}?page=100"
        json = response.parsed_body

        expect(json["data"]).to be_empty
      end

    end
  end

  describe "GET /api/v1/trips/:id" do
    let(:trip) { create(:trip) }

    it "returns a successful response" do
      get "#{base_url}/#{trip.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct trip data" do
      get "#{base_url}/#{trip.id}"
      json = response.parsed_body

      expect(json["data"]["id"]).to eq(trip.id)
      expect(json["data"]["name"]).to eq(trip.name)
      expect(json["data"]["image_url"]).to eq(trip.image_url)
      expect(json["data"]["short_description"]).to eq(trip.short_description)
      expect(json["data"]["long_description"]).to eq(trip.long_description)
      expect(json["data"]["rating"]).to eq(trip.rating)
    end

    it "does not include summary-only fields" do
      get "#{base_url}/#{trip.id}"
      json = response.parsed_body

      expect(json["data"]).not_to have_key("created_at")
      expect(json["data"]).not_to have_key("updated_at")
    end

    it "returns 404 when trip is not found" do
      get "#{base_url}/11111111"
      expect(response).to have_http_status(:not_found)
    end

  end

  describe "POST /api/v1/trips" do
    let(:valid_attributes) do
      {
        trip: {
          name: "A new trip",
          image_url: "https://example.com/new-trip.jpg",
          short_description: "A new trip",
          long_description: "Detailed description of a new trip",
          rating: 4
        }
      }
    end

    context "with valid input" do
      it "creates a new trip" do
        expect {
          post base_url, params: valid_attributes
        }.to change(Trip, :count).by(1)
      end

      it "returns a created status" do
        post base_url, params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it "returns the created trip data" do
        post base_url, params: valid_attributes
        json = response.parsed_body

        expect(json["data"]["name"]).to eq("A new trip")
        expect(json["data"]["rating"]).to eq(4)
        expect(json["data"]).to have_key("id")
      end

      it "includes all provided fields in response" do
        post base_url, params: valid_attributes
        json = response.parsed_body

        expect(json["data"]["name"]).to eq(valid_attributes[:trip][:name])
        expect(json["data"]["image_url"]).to eq(valid_attributes[:trip][:image_url])
        expect(json["data"]["short_description"]).to eq(valid_attributes[:trip][:short_description])
        expect(json["data"]["long_description"]).to eq(valid_attributes[:trip][:long_description])
        expect(json["data"]["rating"]).to eq(valid_attributes[:trip][:rating])
      end
    end

    context "with invalid input" do
      it "returns unprocessable entity when name is missing" do
        invalid_attributes = { trip: { rating: 4 } }

        post base_url, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns unprocessable entity when rating is missing" do
        invalid_attributes = { trip: { name: "Test" } }

        post base_url, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns unprocessable entity when rating is out of range" do
        invalid_attributes = { trip: { name: "Test", rating: 10 } }

        post base_url, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns unprocessable entity when rating is not an integer" do
        invalid_attributes = { trip: { name: "Test", rating: 3.5 } }

        post base_url, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns unprocessable entity when image_url is invalid" do
        invalid_attributes = { trip: { name: "Test", rating: 4, image_url: "not-a-url" } }

        post base_url, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns error message with validation details" do
        invalid_attributes = { trip: { rating: 10 } }

        post base_url, params: invalid_attributes
        json = response.parsed_body

        expect(json["error"]).to eq("Trip fields validation failed")
        expect(json["errors"]).to have_key("name")
        expect(json["errors"]).to have_key("rating")
      end

      it "does not create a trip with invalid input" do
        invalid_attributes = { trip: { rating: 10 } }

        expect {
          post base_url, params: invalid_attributes
        }.not_to change(Trip, :count)
      end

      it "returns error response when all fields are missing" do
        invalid_attributes = { trip: {} }

        post base_url, params: invalid_attributes
        expect(response.status).to be >= 400
      end
    end
  end
end
