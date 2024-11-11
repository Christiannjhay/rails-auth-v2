class Room < ApplicationRecord
  belongs_to :hotel
  
  validates :room_type, :capacity, :description, :price, presence: true
  

  
end
