class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :price
      t.string :size
      t.string :contact_info
      t.string :url
      t.datetime :last_fetched_at
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
