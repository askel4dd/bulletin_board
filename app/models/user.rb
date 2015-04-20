class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  validates :email, :encrypted_password, :login, :fname, :lname, :birthday,
            :address, :city, :zip, :state, :country, presence: true
  belongs_to :role
  has_many :adverts
  has_many :comments
  before_save :set_role
  geocoded_by :full_address
  after_validation :geocode#, if: ->(obj){ obj.full_address.changed? }

  def full_address
    [zip, address, city, state, country].compact.join(', ')
  end

  def set_role
    self.role = Role.find_by(name: "Generic") if self.role.nil?
  end

  def role?(role)
    return false if self.try(:role) == nil
    self.role.name.downcase.to_sym == role
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token
    user = User.where(uid: data["uid"], provider: data["provider"]).first || User.new
    # Uncomment the section below if you want users to be created if they don't exist
    #unless user
    #  user = User.create(login: data["name"],
    #        email: data["email"],
    #        password: Devise.friendly_token[0,20])
    #end
    #user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"] && session['devise.google_data']['extra']['raw_info']
        user.email = data["email"] if user.email.blank?
        user.fname = data["given_name"] if user.fname.blank?
        user.lname = data["family_name"] if user.lname.blank?
        user.birthday = data["birthday"] if user.birthday.blank?
        user.uid = session["devise.google_data"]["uid"]
        user.provider = session["devise.google_data"]["provider"]
      end
    end
  end
end
