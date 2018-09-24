class Blog < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true,length: { in: 1..50 }
  # validates :content,length: { in: 1..140 }
  # validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user
  # def message_time
  #  created_at.strftime("%m/%d/%y at %l:%M %p")
  # end
end
