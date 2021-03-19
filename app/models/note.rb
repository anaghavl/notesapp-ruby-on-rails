class Note < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  validates :tag, presence: true


end
