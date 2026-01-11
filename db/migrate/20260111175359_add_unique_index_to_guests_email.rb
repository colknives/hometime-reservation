class AddUniqueIndexToGuestsEmail < ActiveRecord::Migration[8.1]
  def change
    add_index :guests, "lower(email)", unique: true, name: "index_guests_on_lower_email"
  end
end