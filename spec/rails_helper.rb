require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rspec/rails"
require "factory_bot_rails"

abort("The Rails environment is running in production mode!") if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join("spec/fixtures")]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  factory :trip do
    sequence(:name) { |n| "Amazing Trip #{n}" }
    image_url { "https://example.com/image.jpg" }
    short_description { "A brief description" }
    long_description { "A detailed description of this wonderful trip experience" }
    rating { rand(1..5) }
  end
end
