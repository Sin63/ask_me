class Question < ApplicationRecord
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :text, presence: true
  validates :text, length: { maximum: 255 }
end
