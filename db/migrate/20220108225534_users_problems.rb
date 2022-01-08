class UsersProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems_users, id: false do |t|
      t.references :problem, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
