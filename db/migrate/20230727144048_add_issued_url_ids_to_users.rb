class AddIssuedUrlIdsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :issued_url, foreign_key: true
  end
end
