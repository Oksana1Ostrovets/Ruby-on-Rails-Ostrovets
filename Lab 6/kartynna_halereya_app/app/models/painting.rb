class Painting < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  validates :title, presence: true
  validates :year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :author_id, message: "Ця картина вже існує у цього автора." }
  delegate :name, to: :author, prefix: true, allow_nil: true
end
