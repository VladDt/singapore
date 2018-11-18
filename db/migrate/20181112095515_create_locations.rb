class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :user, foreign_key: true
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
