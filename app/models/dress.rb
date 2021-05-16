class Dress < ApplicationRecord
    validates :name, presence: true
    validates :color, presence: true
    validates :size, presence: true
    validates :price, presence: true
    validates :description, presence: true
    
    belongs_to :category
    belongs_to :user
end
