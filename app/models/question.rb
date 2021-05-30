class Question < ActiveRecord::Base

  has_many :answers
  belongs_to :user

  scope :available, -> { where(private: false) }
end
