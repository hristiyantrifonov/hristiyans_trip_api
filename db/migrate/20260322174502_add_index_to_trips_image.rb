class AddIndexToTripsImage < ActiveRecord::Migration[8.1]
  def change
    add_index :trips, :image_url
  end
end
