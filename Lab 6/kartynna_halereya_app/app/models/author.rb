class Author < ApplicationRecord
  has_many :paintings, dependent: :destroy

  validates :name, presence: true
  validates :birth_year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }
  validates :country, presence: true
  
  validates :name, uniqueness: { scope: [:birth_year, :country], message: "такий автор вже існує в цій країні з таким роком народження" }
end
