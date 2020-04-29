class Picture < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :title, presence: true, length: { in: 1..50 }
  validates :content, presence: true, length: { in: 1..350 }

  mount_uploader :image, ImageUploader
end
