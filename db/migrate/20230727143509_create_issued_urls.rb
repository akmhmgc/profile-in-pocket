class CreateIssuedUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :issued_urls do |t|
      t.string :url_key, null: false, unique: true
      t.timestamps
    end
  end
end
