class Answer < ApplicationRecord
  belongs_to :question
  validates :evaluation, presence: true
  validates :body, length: {maximum: 255}

  enum evaluation: { 中立: 0, 現状で良い: 'good',中立:'avarage' ,変化してほしい: 'poor'}
end
