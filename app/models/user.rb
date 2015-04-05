class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  validates :email, :encrypted_password, :login, :fname, :lname, :birthday,
            :address, :city, :zip, :state, presence: true
  belongs_to :role
  has_many :adverts
  has_many :comments
  before_save :set_role

  def set_role
    self.role = Role.find_by(name: "Generic") if self.role.nil?
  end

  def role?(role)
    return false if self.role == nil
    self.role.name.downcase.to_sym == role
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(login: data["name"],
            email: data["email"],
            password: Devise.friendly_token[0,20]
         )
     end
    user
  end
end
