# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)
#  salt                   :string(255)
#  admin                  :boolean          default(FALSE)
#  provider               :string(255)
#  uid                    :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :omniauthable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :username, :email, :password, :password_confirmation, :remember_me, :provider, :uid

  #attr_accessible :email, :name, :password, :password_confirmation, :salt, :encrypted_password

  has_many :sittings
  has_many :tasks,  :through => :sittings

  def to_s
    name || email
  end

  def self.find_for_oatuh_uid(auth)
    User.where(provider: auth.provider, uid: auth.uid).first
  end

  def self.find_for_oauth_mail(auth)
    user = User.where(email: auth.info.email).first
    if user
      user.update_attributes(provider: auth.provider, uid: auth.uid)
      user.save
    end
    user
  end

  def self.find_for_google_oauth(auth, signed_in_resource=nil)
    user = User.find_for_oatuh_uid(auth) || User.find_for_oauth_mail(auth)
    user ||= User.create(
                         name: auth.info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: Devise.friendly_token[0,20]
                         )
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.oauth_data"]
        user.email = data["email"] if user.email.blank?
        user.name = (data["name"]) if user.username.blank?
      end
    end
  end

end
