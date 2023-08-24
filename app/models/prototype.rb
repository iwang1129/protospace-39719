
class Prototype < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  has_one_attached :image
end