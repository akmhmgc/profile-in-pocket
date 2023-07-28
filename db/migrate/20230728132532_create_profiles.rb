class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name, null: false, comment: '名前'
      t.text :description, null: false, comment: '自己紹介文'
      t.string :twitter_id, comment: 'Twitter ID'
      t.string :github_id, comment: 'GitHub ID'
      t.string :qiita_id, comment: 'Qiita ID'
      t.string :zenn_id, comment: 'Zenn ID'
      t.string :url, comment: 'URL'
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
