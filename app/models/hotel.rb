class Hotel < ApplicationRecord

   # Validations
   validates :name, presence: true
   validates :location, presence: true
   validates :description, presence: true
   
end
