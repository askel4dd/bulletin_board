class Advert < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_many :comments, dependent: :delete_all
  validates :title, :description, presence: true
  mount_uploader :image, ImageUploader
  acts_as_taggable
  pg_search_scope :custom_search,
    against: [:title, :description]
   # text :user do
   #   [user.login, user.country, user.state, user.city, user.address]
   # end
   # text :tags do
   #   tags.map { |tag| tag.name }
   # end
end
