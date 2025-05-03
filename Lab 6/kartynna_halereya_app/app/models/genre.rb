class Genre < ApplicationRecord
    has_many :paintings, dependent: :destroy
  
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
  end
  