class TechniquesProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems_techniques, id: false do |t|
      t.references :problem, foreign_key: true
      t.references :technique, foreign_key: true
      
      t.timestamps
    end
  end
end
