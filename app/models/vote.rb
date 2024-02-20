class Vote < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :title, presence: true,
                      length: {maximum: 50}
  validates :description, presence: true,
                      length: {maximum: 140}
end
