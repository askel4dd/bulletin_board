class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :advert
  validates :body, presence: true
end
