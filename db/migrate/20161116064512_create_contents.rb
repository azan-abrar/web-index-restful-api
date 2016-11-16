class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :content_type
      t.text :content_text
      t.references :website, index: true, foreign_key: true
      t.timestamps
    end
  end
end
