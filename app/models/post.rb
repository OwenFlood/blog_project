class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {minimum: 7}, uniqueness: {scope: :body}

  validates :body, presence: true

  def body_snippet
    body.length > 100 ? body[0..99] + "..." : body
  end

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
