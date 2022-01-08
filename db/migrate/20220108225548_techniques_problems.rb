class TechniquesProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems_techniques, id: false do |t|
      t.belongs_to :technique
      t.belongs_to :problem

      t.timestamps
    end
  end
end
