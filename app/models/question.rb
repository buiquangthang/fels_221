class Question < ApplicationRecord
  belongs_to :category
  has_many :learns, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: proc { |attributes| attributes["content"].blank? }, allow_destroy: true

  validates :content, presence:true

  scope :of_category, -> category_id {where category_id: category_id}
  scope :list_learned, -> learned_ids {where id: learned_ids}
  scope :search_content, -> keyword {where "LOWER(content) LIKE ?", "%#{keyword}%"}
  scope :question_not_learn, -> learned_ids {where "id NOT IN (?)", learned_ids}
  scope :order_by_date, -> {order created_at: :desc}
  scope :search_by_content, -> content do
    if content
      where "content LIKE ?", "%#{content}%"
    end
  end
  scope :search_by_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  scope :filter_by, -> category_id, search do
    questions = Question.all
    if category_id && !category_id.empty?
      questions = questions.where(category_id: category_id)
    end
    if search
      questions = questions.where("content LIKE '%#{search}%'")
    end
    questions
  end
end
