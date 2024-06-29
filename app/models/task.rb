class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  validates :description, length: { maximum: 100 }
end
