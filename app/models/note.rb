class Note < ApplicationRecord
  #Notes belong to user
  belongs_to :user

  #Validations to check presence of attributes
  validates :title, presence: true
  validates :body, presence: true
  validates :tag, presence: true
end
