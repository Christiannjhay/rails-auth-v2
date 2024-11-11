class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.references :hotel, null: false, foreign_key: true
      t.string :room_type
      t.text :description
      t.integer :capacity
      t.json :amenities
      t.json :media
      t.decimal :price

      t.timestamps
    end
  end
end
