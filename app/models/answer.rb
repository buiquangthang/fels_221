class Answer < ApplicationRecord
  belongs_to :question, optional: true
  has_many :learns
  scope :get_answer_by, -> question_id {where("question_id = ? AND is_correct = 't'", question_id)}
end
