class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :age
      t.integer :gender
      t.text :about
      t.references :coach, null: true, foreign_key: true

      t.timestamps
    end
  end
end
