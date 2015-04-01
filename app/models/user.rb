class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, :encrypted_password, :login, :fname, :lname, :birthday,
            :address, :city, :zip, :state, presence: true
  belongs_to :role
  has_many :adverts
  before_save :set_role
  
  def set_role
    self.role = Role.find_by(name: "Generic") if self.role.nil?
  end
  def role?(role)
    return false if self.role == nil
    self.role.name.downcase.to_sym == role
  end
end
