class CreateSocials < ActiveRecord::Migration[6.1]
  def change
    create_table :socials do |t|
      t.text :title
      t.references :coach, null: true, foreign_key: true

      t.timestamps
    end
  end
end
