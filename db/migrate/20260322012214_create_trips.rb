class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :image_url
      t.string :short_description
      t.text :long_description
      t.integer :rating

      t.timestamps
    end

    add_check_constraint :trips,
                         "rating >= 1 AND rating <= 5",
                         name: "rating_between_1_and_5"
  end
end
