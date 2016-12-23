class Learn < ApplicationRecord
  belongs_to :question
  belongs_to :answer, optional: true
  belongs_to :lesson, optional: true

  scope :learned_ids, -> user_id, category do
    lessons = Lesson.of_user(user_id).of_category(category)
    self.add_question_id lessons
  end

  scope :learned_ids_without_category, -> user_id do
    lessons = Lesson.of_user user_id
    self.add_question_id lessons
  end

  scope :had_learn_before, -> user_id, learned_ids do
    lessons = Lesson.of_user user_id
    not_learned_ids = []
    lessons.each do |lesson|
      lesson.learns.each do |learn|
        if !learned_ids.include?(learn.question_id)
          not_learned_ids << learn.question_id
        end
      end
    end
    not_learned_ids
  end

  scope :add_question_id, -> lessons do
    learned_ids = []
    lessons.each do |lesson|
      lesson.learns.is_correct.each do |learn|
        learned_ids << learn.question_id
      end
    end
    learned_ids
  end

  scope :is_correct, -> {where is_correct: true}
  
  def self.check_correct_answer answer_id
    unless answer_id
      return false
    end
    Answer.find_by(id: answer_id).is_correct
  end
end
