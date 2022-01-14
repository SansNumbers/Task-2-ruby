class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :age
      t.integer :gender
      t.text :about
      t.text :experience
      t.text :licenses
      t.text :education
      t.text :socials

      t.timestamps
    end
  end
end
