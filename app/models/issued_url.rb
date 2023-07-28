class IssuedUrl < ApplicationRecord
  has_one :user, dependent: :destroy
  validates :url_key, presence: true, uniqueness: true

  class << self
    def create_unique_url_key
      loop do
        url_key = SecureRandom.hex(16)
        break url_key unless IssuedUrl.exists?(url_key: url_key)
      end
    end

    def create_issue_urls(counts:)
      counts.times do
        IssuedUrl.create(url_key: create_unique_url_key)
      end
    end
  end
end
