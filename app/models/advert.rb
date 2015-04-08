class Advert < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :delete_all
  mount_uploader :image, ImageUploader
  acts_as_taggable
  searchable do
    text :title, :description
  end
end
