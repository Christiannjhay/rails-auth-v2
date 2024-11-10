class CreateHotels < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.string :location
      t.json :amenities
      t.json :media

      t.timestamps
    end
  end
end
