class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォロー側の視点
  has_many :active_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  # フォローされる側の視点
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }


  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search(search, search_method)
    if search_method == "forward_match"
       User.where(['name LIKE ?', "#{search}%"])
    elsif
       search_method == "perfect_match"
       User.where(['name LIKE ?', "#{search}"])
    elsif
       search_method == "backward_match"
       User.where(['name LIKE ?', "%#{search}"])
    elsif
       search_method == "partial_match"
       User.where(['name LIKE ?', "%#{search}%"])
    end
  end
end
