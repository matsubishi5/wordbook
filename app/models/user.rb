class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  # レート順ランキング
  def self.ranking
    self.all.order(highest_rate: 'DESC')
  end

  # 自分の順位を計算
  def my_rank
    users = User.ranking
    my_rank = 0
    users.each do |user|
      my_rank += 1
      break if user.id == self.id
    end
    my_rank
  end
end
