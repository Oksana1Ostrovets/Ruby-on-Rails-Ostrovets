class Author < ApplicationRecord
    has_many :paintings, dependent: :destroy
  
    validates :name, presence: true
    validates :birth_year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }
    validates :country, presence: true
  end
  