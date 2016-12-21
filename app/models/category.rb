class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy

  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :search_by_name, -> name {where "categories.name LIKE ?", "%#{name}%"}

  scope :order_by_date, -> {order created_at: :desc}
end
