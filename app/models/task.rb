class Task < ApplicationRecord
    validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: false, length: { maximum: 255 }
end
