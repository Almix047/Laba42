# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  validates :name, presence: true

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.password = Devise.friendly_token
      user.email = auth.info.email
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
    end
  end
end