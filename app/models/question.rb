class Question < ApplicationRecord
  has_many :question_similars, dependent: :destroy

  def self.search(search)
    if search.present?
      Question.where(['question LIKE ? OR description LIKE ?', "%#{ search }%", "%#{ search }%"])
    end
  end
end
