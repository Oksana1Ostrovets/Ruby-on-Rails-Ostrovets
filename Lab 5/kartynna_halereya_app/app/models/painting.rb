class Painting < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  validates :title, presence: true
  validates :year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
