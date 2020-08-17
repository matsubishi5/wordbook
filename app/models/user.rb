class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true

  def self.ranking
    self.all.order(highest_rate: 'DESC')
  end

  def my_rank(current_user)
    users = User.ranking
    @my_rank = 0
    users.each do |user|
      @my_rank += 1
      break if user.id == current_user.id
    end
    @my_rank
  end
end
