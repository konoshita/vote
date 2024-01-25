class Answer < ApplicationRecord
  belongs_to :question
  validates :evaluation, presence: true
  validates :body, length: {maximum: 255}
end
