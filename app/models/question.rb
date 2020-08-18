class Question < ApplicationRecord
  has_many :question_similars, dependent: :destroy
  accepts_nested_attributes_for :question_similars

  validates :question, presence: true, uniqueness: true
  validates :description, presence: true

  # あいまい検索
  def self.search(search)
    if search.present?
      Question.where(['question LIKE ? OR description LIKE ?', "%#{ search }%", "%#{ search }%"])
    end
  end
end
