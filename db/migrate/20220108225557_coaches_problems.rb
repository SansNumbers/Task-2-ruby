class CoachesProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches_problems, id: false do |t|
      t.references :problem, foreign_key: true
      t.references :coach, foreign_key: true

      t.timestamps
    end
  end
end
