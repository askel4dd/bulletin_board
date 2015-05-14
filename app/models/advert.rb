class Advert < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_many :comments, dependent: :delete_all
  validates :title, :description, presence: true
  mount_uploader :image, ImageUploader
  acts_as_taggable
  pg_search_scope :custom_search,
    against: [:title, :description],
    associated_against: { user: [:login, :country, :state, :city, :address],
                          tags: :name }
end
