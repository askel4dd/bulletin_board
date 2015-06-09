class Advert < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_many :comments, dependent: :delete_all
  validates :title, :description, presence: true
  validate :max_adverts
  mount_uploader :image, ImageUploader
  acts_as_taggable
  pg_search_scope :custom_search,
    against: [:title, :description],
    associated_against: { user: [:login, :country, :state, :city, :address],
                          tags: :name }

  def max_adverts
    if user.adverts.count > 10
      errors.add(:title,"Too many adverts")
    end
  end
end
