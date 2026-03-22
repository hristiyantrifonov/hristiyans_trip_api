class Trip < ApplicationRecord
  validates :name, presence: true

  validates :rating,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

  validates :image_url,
            format: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
            allow_blank: true
end