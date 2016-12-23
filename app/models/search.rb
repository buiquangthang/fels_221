class Search < ApplicationRecord

  enum learn: [:had_learn, :not_learn, :remember]
  def search_words user
    words = Question.all
    words = words.search_content keyword if keyword.present?
    if category.present?
      learned_ids = Learn.learned_ids user.id, category
      words = words.of_category category
    else
      learned_ids = Learn.learned_ids_without_category user.id
    end
    had_learned learned_ids, words, user.id
  end

  def had_learned learned_ids, words, user_id
    if self.remember?
      words = words.list_learned learned_ids
    elsif learned_ids.any? && self.not_learn? 
      words = words.question_not_learn learned_ids
      words = words.where("id NOT IN (?)", Learn.had_learn_before(user_id, learned_ids))
    elsif self.had_learn?
      words = words.list_learned(Learn.had_learn_before(user_id, learned_ids)).uniq
    end
    words
  end
end
