class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  validates :content, presence: true
  def message_time
   created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
