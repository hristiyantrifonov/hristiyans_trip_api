class AddIndexToTripsRating < ActiveRecord::Migration[8.1]
  def change
    add_index :trips, :rating
  end
end
