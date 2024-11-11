class Hotel < ApplicationRecord
   has_many :rooms, dependent: :destroy
   
   validates :name, presence: true
   validates :location, presence: true
   validates :description, presence: true
   
end
