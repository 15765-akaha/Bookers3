class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }

  def self.search(search, search_method)
    if search_method == "forward_match"
       Book.where(['title LIKE ?', "#{search}%"])
    elsif
       search_method == "perfect_match"
       Book.where(['title LIKE ?', "#{search}"])
    elsif
       search_method == "backward_match"
       Book.where(['title LIKE ?', "%#{search}"])
    elsif
       search_method == "partial_match"
       Book.where(['title LIKE ?', "%#{search}%"])
    end
  end
end
