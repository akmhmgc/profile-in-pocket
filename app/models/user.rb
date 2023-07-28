class User < ApplicationRecord
  belongs_to :issued_url
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  class << self
    def find_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      user = find_by(email: user_params[:email])
      user
    end

    def initialize_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      user = build(email: user_params[:email])
      user.assign_attributes(user_params)
      user
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        name: auth_hash.info.name,
        email: auth_hash.info.email,
        image: auth_hash.info.image
      }
    end
  end
end
